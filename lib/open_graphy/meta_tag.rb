module OpenGraphy
  class MetaTag
    def initialize(doc, meta_tag)
      @doc, @meta_tag = doc, meta_tag
    end

    def namespace
      @namespace ||= TagNamespace.new(tag_name.split(':'))
    end

    def valid?
      tag_name
    end

    def name
      @meta_tag.attr('property').sub(tag_name, '')
    end

    def value
      @meta_tag.attr('content').to_s
    end

    private

    def tag_name
      OpenGraphy.configuration.metatags.find do |valid_meta_tag_name|
        @meta_tag.attr('property') =~ Regexp.new(valid_meta_tag_name)
      end
    end
  end
end
