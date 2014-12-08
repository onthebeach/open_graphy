module OpenGraphy
  module Uri
    class Fetcher
      def initialize(uri_str, limit = 10)
        @uri_str, @limit = uri_str, limit
      end

      def fetch
        check_redirect_limit

        http_response = response
        case http_response
        when Net::HTTPSuccess then
          http_response
        when Net::HTTPRedirection then
          follow_redirection(http_response)
        else
          http_response.value
        end
      end

      private

      def follow_redirection(http_response)
        @uri_str = http_response['location']
        @limit -= 1
        self.fetch
      end

      def check_redirect_limit
        raise  Uri::RedirectLoopError, 'too many HTTP redirects' if @limit == 0
      end

      def uri
        uri = URI(@uri_str)
        raise BadUriError, 'the url is incomplete' if uri.host == nil

        uri
      end

      def response
        Net::HTTP.get_response(uri)
      end
    end
  end
end
