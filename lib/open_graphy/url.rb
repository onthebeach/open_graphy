module OpenGraphy
  class Url
    def initialize(uri)
      @uri = uri
    end

    def self.fetch(uri)
      new(uri).fetch
    end

    def fetch
      data.add('url', @uri)
      begin
        valid_meta_tags.each { |tag| data.add(tag.name, tag.value) }
        data.add('__html_title_tag',  doc.css('title').text)
      rescue Net::HTTPServerException, RedirectLoopError
      end

      data
    end

    private

    def valid_meta_tags
      valid_meta_tags ||= meta_tags.select(&:valid?)
    end

    def meta_tags
      doc.css('meta').map { |tag| MetaTag.new(doc, tag) }
    end

    def data
      @data ||= MetaTags.new
    end

    def doc
      @doc ||= Nokogiri::HTML(Uri.open(@uri))
    end
  end
end
