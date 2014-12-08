module OpenGraphy
  class UrlValidator
    def initialize(url)
      @url = url
    end

    def valid?
     !!(@url =~ /\A#{URI::regexp(['http', 'https'])}\z/)
    end
  end
end
