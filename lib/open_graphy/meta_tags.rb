module OpenGraphy
  class MetaTags
    def title
      data.fetch('title', __html_title_tag)
    end

    def title?
      !!title
    end

    def image
      if valid_image_url?
        image_url
      else
        raise NoMethodError
      end
    end

    def image?
      valid_image_url?
    end

    def add(key, value, namespace: TagNamespace.new)
      data[key] = value
      if namespace.any?
        if respond_to?(namespace.first)
          public_send(namespace.first).add(key, value, namespace: namespace.next)
        else
          tag = MetaTags.new.add(key, value, namespace: namespace.next)
          define_singleton_method(namespace.first, -> { tag })
        end
      else
        if define_accessors?(key)
          define_singleton_method key, -> { value }
          define_singleton_method "#{key}?", -> { !!value }
        end
      end
      self
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

    def image_url
      data.fetch('image', false)
    end

    def valid_image_url?
      @valid_image_url ||= UrlValidator.new(image_url).valid?
    end

    def define_accessors?(key)
      !black_list.include?(key)
    end

    def black_list
      %w(image)
    end

    def data
      @data ||= {}
    end

    def __html_title_tag
      @data['__html_title_tag']
    end
  end
end
