module OpenGraphy
  class TagNamespace
    extend Forwardable
    include Enumerable

    def_delegators :namespace, :empty?, :length, :each, :last, :first, :any?, :size, :[]

    def initialize(namespace=[])
      @namespace = namespace
    end

    def any?
      namespace.any? && first != 'og'
    end

    def add_to(key, value, tag)
      if any?
        tag.define_namespace(child_name).add(key, value, namespace: self.next)
      else
        tag.define_value(key, value)
      end
    end

    def child_name
      namespace.first
    end

    def next
      TagNamespace.new(
        [namespace.size > 1 ? namespace.last : nil].compact
      )
    end

    private

    def namespace
      @namespace
    end
  end
end
