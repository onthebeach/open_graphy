module OpenGraphy
  class Fetcher
    def initialize(uri)
      @uri = uri
    end

    def self.fetch(uri)
      new(uri).fetch
    end

    def fetch
      valid_meta_tags.each do |tag|
        data.add_data(tag.name, tag.value)
      end

      if !data.title
        data.add_data("title",  doc.css('title').text)
      end

      data
    end

    private

    def valid_meta_tags
      valid_meta_tags ||= meta_tags.select(&:valid?)
    end

    class MetaTag
      def initialize(doc, meta_tag)
        @doc, @meta_tag = doc, meta_tag
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

    def meta_tags
      doc.css('//meta').map { |tag| MetaTag.new(doc, tag) }
    end

    def data
      @data ||= Data.new
    end

    def doc
      @doc ||= Nokogiri::HTML(open(@uri))
    end
  end
end
