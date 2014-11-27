require 'open_graphy/version'
require 'nokogiri'
require 'open-uri'
require 'socket'
require 'singleton'
require 'open_graphy/configuration'
require 'open_graphy/url'
require 'open_graphy/meta_tags'
require 'open_graphy/meta_tag'

module OpenGraphy
  def self.configuration
    Configuration.instance
  end

  def self.configure
    yield(configuration)
  end

  def self.fetch(uri)
    Url.fetch(uri)
  end
end
