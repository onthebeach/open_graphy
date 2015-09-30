module OpenGraphy
  class Configuration
    include Singleton
    attr_accessor :metatags, :user_agent

    def initialize
      @metatags = ['og:']
      @user_agent = 'OpenGraphyBot'
    end
  end
end
