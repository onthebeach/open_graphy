require 'spec_helper'

module OpenGraphy
  describe Url do
    describe '.fetch' do
      let(:og_data) { Url.fetch(uri) }
      let(:uri) { 'http://www.imdb.com/title/tt0107048/' }
      let(:meta_tags) { [] }
      let(:file) { File.new('spec/support/fixtures/groundhog_day.html') }

      before do
        expect(Uri).to receive(:open).with(uri).
          and_return(file)
      end

      it 'has a url' do
        expect(og_data.url).to eql('http://www.imdb.com/title/tt0107048/')
      end

      it 'has an image' do
        expect(og_data.image).to eql('http://ia.media-imdb.com/images/M/MV5BMTU0MzQyNTExMV5BMl5BanBnXkFtZTgwMjA0Njk1MDE@._V1_.jpg')
      end

      it 'has a title' do
        expect(og_data.title).to eql('Groundhog Day (1993)')
      end

      it 'thinks it has an image' do
        expect(og_data.image?).to eql(true)
      end

      it 'does not have a cat' do
        expect(og_data.cat?).to eql(false)
      end
    end
  end
end
