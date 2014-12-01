require 'spec_helper'

describe OpenGraphy, :vcr do
  subject { OpenGraphy.fetch(url) }

  let(:url) { 'http://www.imdb.com/title/tt2084970/?ref_=inth_ov_tt' }

  describe '.fetch' do
    it 'should return an object with the opengraph data' do
      expect(subject).to be_kind_of(OpenGraphy::MetaTags)
    end
  end

  describe 'custom metatags' do
    let(:open_graphy) { OpenGraphy.fetch(url) }
    let(:url) { 'https://www.onthebeach.co.uk/deals/53ee67c676036401a67eab73026a97f9/e01a07efddb6e124da373b31222c162f/80507aab0fb81591a992fcc5b77d93a4' }
    before do
      OpenGraphy.configure do |config|
        config.metatags = ["og:", "onthebeach:deal:", "onthebeach:hotel:"]
      end
    end

    it { expect(open_graphy.title).to eq('Vilamoura Golf (Vilamoura, Costa de Algarve, Portugal)') }
    it { expect(open_graphy.description).to include('With nearly 200 km of unrivalled coastline') }
    it { expect(open_graphy.image).to eq('http://hotels.onthebeach.co.uk/assets/hotel_images/000/345/599/original/vilamoura-golf.jpg') }
    it { expect(open_graphy.type).to eq('website') }
    it { expect(open_graphy.url).to eq('https://www.onthebeach.co.uk/deals/53ee67c676036401a67eab73026a97f9/e01a07efddb6e124da373b31222c162f/80507aab0fb81591a992fcc5b77d93a4') }
    it { expect(open_graphy.site_name).to eq('On The Beach') }
    it { expect(open_graphy.id).to eq('53ee67c676036401a67eab73026a97f9') }
    it { expect(open_graphy.hotel_id).to eq('281399') }
    it { expect(open_graphy.board_code).to eq('SC') }
    it { expect(open_graphy.price).to eq('287.40') }
    it { expect(open_graphy.hotel_result_id).to eq('53ee67c676036401a67eab73026a97f9') }
    it { expect(open_graphy.board_result_id).to eq('b736a3ddafc484424470a056445671d4') }
    it { expect(open_graphy.flight_result_id).to eq('80507aab0fb81591a992fcc5b77d93a4') }
  end

  describe 'try to fetch a webpage that does not exist' do
    let(:open_graphy_data) { OpenGraphy.fetch('http://google.com/404.html') }

    it "return data class with url" do
      expect(open_graphy_data.url).to eql('http://google.com/404.html')
    end
  end
end
