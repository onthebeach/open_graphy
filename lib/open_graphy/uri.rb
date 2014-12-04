require 'net/http'

module OpenGraphy
  module Uri
    class RedirectLoopError < StandardError; end
    class BadUriError < StandardError; end

    def self.open(uri_str)
      fetch(uri_str).body
    end

    private

    def self.fetch(uri_str, limit = 10)
      raise  RedirectLoopError, 'too many HTTP redirects' if limit == 0
      uri = URI(uri_str)

      raise BadUriError, 'the url is incomplete' if uri.host == nil

      response = Net::HTTP.get_response(uri)

      case response
      when Net::HTTPSuccess then
        response
      when Net::HTTPRedirection then
        location = response['location']
        fetch(location, limit - 1)
      else
        response.value
      end
    end
  end
end
