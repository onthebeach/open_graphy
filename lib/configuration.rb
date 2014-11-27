module OpenGraphy
  class Configuration
    include Singleton
    attr_accessor :metatags

    def initialize
      @metatags = ['og:']
    end
  end
end
