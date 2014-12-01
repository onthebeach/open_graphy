module OpenGraphy
  class MetaTags
    def title
      data.fetch('title', __html_title_tag)
    end

    def title?
      !!title
    end

    def add(key, value)
      data[key] = value
      define_singleton_method key, lambda { value }
      define_singleton_method "#{key}?", lambda { !!value }
    end

    def method_missing(method_sym, *arguments, &block)
      if method_sym.to_s.sub(/.?$/, "")
        false
      else
        super
      end
    end

    private

    def data
      @data ||= {}
    end

    def __html_title_tag
      @data['__html_title_tag']
    end
  end
end
