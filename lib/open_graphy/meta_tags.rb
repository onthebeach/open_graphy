module OpenGraphy
  class MetaTags
    def initialize
      @data = {}
    end

    def title
      @data.fetch('title', __html_title_tag)
    end

    def title?
      title
    end

    def __html_title_tag
      @data['__html_title_tag']
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
