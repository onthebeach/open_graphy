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
