require 'open_graphy/version'
require 'nokogiri'
require 'open-uri'
require 'socket'
require 'singleton'
require 'open_graphy/configuration'
require 'open_graphy/fetcher'
require 'open_graphy/data'
require 'open_graphy/meta_tag'

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
end
