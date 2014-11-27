require "open_graphy/version"
require "nokogiri"
require "open-uri"
require "singleton"
require "configuration"

module OpenGraphy
  def self.configuration
    Configuration.instance
  end

  def self.configure
    yield(configuration)
  end

  def self.fetch(uri)
    parse(uri)
  end

  def self.parse(uri)
    doc = Nokogiri::HTML(open(uri))
    data = Data.new
    doc.css('//meta').each do |tag|
      configuration.metatags.each do |metatag|
        if tag.attr('property') =~ Regexp.new(metatag)
          key = tag.attr('property').sub(metatag, '')
          data.add_data(key, tag.attr('content').to_s)
        end
      end
    end
    if !data.title
      data.add_data("title",  doc.css('title').text)
    end
    data
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
