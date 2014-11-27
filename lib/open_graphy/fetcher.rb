module OpenGraphy
  class Fetcher
    def initialize(uri)
      @uri = uri
    end

    def self.fetch(uri)
      new(uri).fetch
    end

    def fetch
      meta_tags.each do |tag|
        OpenGraphy.configuration.metatags.each do |metatag|
          if tag.attr('property') =~ Regexp.new(metatag)
            key = tag.attr('property').sub(metatag, '')
            data.add_data(key, tag.attr('content').to_s)
          end
        end
      end
      if !data.title
        data.add_data("title",  doc.css('title').text)
      end
      data
    end

    private

    def meta_tags
      doc.css('//meta')
    end

    def data
      @data ||= Data.new
    end

    def doc
      @doc ||= Nokogiri::HTML(open(@uri))
    end
  end
end
