require 'net/http'

module OpenGraphy
  module Uri
    class RedirectLoopError < StandardError; end
    class BadUriError < StandardError; end

    def self.open(uri_str)
      fetch(uri_str).body
    end

    def self.fetch(uri)
      Fetcher.new(uri).fetch
    end
  end
end
