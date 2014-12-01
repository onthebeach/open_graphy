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
      if method_sym.to_s.end_with?('?')
        false
      else
        super
      end
    end

    def respond_to?(method_name, include_private = false)
      method_name.to_s.end_with?('?') || super
    end

    def respond_to_missing?(method_name, include_private = false)
      method_name.to_s.end_with?('?') || super
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
