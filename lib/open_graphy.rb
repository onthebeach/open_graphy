require "open_graphy/version"
require "nokogiri"
require "open-uri"

module OpenGraphy
  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  class Configuration
    attr_accessor :metatags
    def initialize
      @metatags = ['og:']
    end
  end

  def self.fetch(uri)
    parse(uri)
  end

  def self.parse(uri)
    doc = Nokogiri::HTML(open(uri))
    data = Data.new
    key = ""
    doc.css('//meta').each do |tag|
      configuration.metatags.each do |metatag|
        if tag.attr('property') =~ Regexp.new(metatag)
          key = tag.attr('property').sub(metatag, '')
          data.define_singleton_method(key) { tag.attr('content').to_s }
          data.add_key(key)
        end
      end
    end
    if data.keys.include?("title") == false
      data.define_singleton_method("title") { doc.css('title').text }
      data.add_key("title")
    end
    data
  end

  class Data
    def initialize
      @keys = []
    end

    def method_missing(method_sym, *arguments, &block)
      false
    end

    def keys
      @keys
    end

    def add_key(key)
      @keys << key
    end
  end
end
