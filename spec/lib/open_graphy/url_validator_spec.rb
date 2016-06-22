module OpenGraphy
  RSpec.describe UrlValidator do

    describe '#fetch' do
      context 'with a valid url' do
        let (:url) { "http://www.onthebeach.co.uk" }

        it 'is a valid' do
          expect(UrlValidator.new(url).valid?).to be(true)
        end
      end

      context 'with an invalid url' do
        let(:url) { "abcde12345" }

        it 'is not valid' do
          expect(UrlValidator.new(url).valid?).to be(false)
        end
      end
    end
  end
end
