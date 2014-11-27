require "open_graphy/version"
require "nokogiri"
require "open-uri"
require "singleton"
require "open_graphy/configuration"
require "open_graphy/fetcher"

module OpenGraphy
  def self.configuration
    Configuration.instance
  end

  def self.configure
    yield(configuration)
  end

  def self.fetch(uri)
    Fetcher.fetch(uri)
  end

  class Data
    def initialize
      @data = {}
    end

    def method_missing(method_sym, *arguments, &block)
      if @data.has_key?(method_sym.to_s)
        @data[method_sym.to_s]
      elsif @data.has_key?(method_sym.to_s.sub(/.?$/, ""))
        true
      else
        false
      end
    end

    def keys
      @data.keys
    end

    def add_data(key, value)
      @data[key] = value
    end
  end
end
