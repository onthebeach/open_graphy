module OpenGraphy
  class Url
    def initialize(uri)
      @uri = uri
    end

    def self.fetch(uri)
      new(uri).fetch
    end

    def fetch
      begin
        valid_meta_tags.each do |tag|
          data.add_data(tag.name, tag.value)
        end
        data.add_data('__html_title_tag',  doc.css('title').text)
      rescue SocketError, Errno::ENOENT
        data.add_data('url', @uri)
      end

      data
    end

    private

    def valid_meta_tags
      valid_meta_tags ||= meta_tags.select(&:valid?)
    end

    def meta_tags
      doc.css('//meta').map { |tag| MetaTag.new(doc, tag) }
    end

    def data
      @data ||= MetaTags.new
    end

    def doc
      @doc ||= Nokogiri::HTML(open(@uri))
    end
  end
end
