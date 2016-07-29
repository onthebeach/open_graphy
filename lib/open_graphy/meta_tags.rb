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
      namespace.add_to(key, value, self)
      self
    end

    def define_namespace(name)
      if respond_to?(name)
        public_send(name)
      else
        MetaTags.new.tap { |tag|
          define_singleton_method(name, -> { tag })
        }
      end
    end

    def define_value(key, value)
      if define_accessors?(key)
        define_singleton_method key, -> { value }
        define_singleton_method "#{key}?", -> { !!value }
      end
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

    def define_accessors?(key)
      !black_list.include?(key)
    end

    def image_url
      data.fetch('image', false)
    end

    def valid_image_url?
      @valid_image_url ||= UrlValidator.new(image_url).valid?
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
