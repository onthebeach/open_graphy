module OpenGraphy
  module Uri
    class Fetcher
      def initialize(uri_str, limit = 10)
        @uri_str, @limit = uri_str, limit
      end

      def fetch
        uri = URI(@uri_str)
        raise BadUriError, 'the url is incomplete' if uri.host == nil

        response = Net::HTTP.get_response(uri)
        case response
        when Net::HTTPSuccess then
          response
        when Net::HTTPRedirection then
          follow_redirection(response)
        else
          response.value
        end
      end

      private

      def follow_redirection(response)
        @uri_str = response['location']
        @limit -= 1
        self.fetch
      end

      def check_redirect_limit
        raise  Uri::RedirectLoopError, 'too many HTTP redirects' if @limit == 0
      end
    end
  end
end
