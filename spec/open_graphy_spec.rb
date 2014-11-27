require 'spec_helper'

describe OpenGraphy, :vcr do
  subject{ OpenGraphy.fetch(url) }

  let(:url){ 'http://www.imdb.com/title/tt2084970/?ref_=inth_ov_tt' }

  describe '.fetch' do
    it 'should return an object with the opengraph data' do
      expect(subject).to be_kind_of(OpenGraphy::Data)
    end
  end

  describe OpenGraphy::Data  do
    it 'should have a title' do
      expect(subject.title).to eq('The Imitation Game (2014)')
    end

    it 'should have a url' do
      expect(subject.url).to eq('http://www.imdb.com/title/tt2084970/')
    end

    it 'should have a type' do
      expect(subject.type).to eq('video.movie')
    end

    let(:expected_image_url){ 'http://ia.media-imdb.com/images/M/MV5BNDkwNTEyMzkzNl5BMl5BanBnXkFtZTgwNTAwNzk3MjE@._V1_.jpg' }

    it 'should have an image' do
      expect(subject.image).to eq(expected_image_url)
    end

    it 'should return false for an undefined method' do
      expect(subject.undefined_method).to eq(false)
    end

    it 'should be able to return the keys of the object' do
      expect(subject.keys).to eq(["url", "image", "type", "title", "site_name", "description"])
    end
  end

  describe OpenGraphy::Configuration do
    before do
      OpenGraphy.configure do |config|
        config.metatags = ["og:", "onthebeach:deal:", "onthebeach:hotel:"]
      end
    end
    describe '#metatags' do
      it{ expect(OpenGraphy.configuration.metatags).to eq(["og:", "onthebeach:deal:", "onthebeach:hotel:"]) }
    end
  end

  describe '#configure' do
    let(:url){'https://www.onthebeach.co.uk/deals/53ee67c676036401a67eab73026a97f9/e01a07efddb6e124da373b31222c162f/80507aab0fb81591a992fcc5b77d93a4'}
    before do
      OpenGraphy.configure do |config|
        config.metatags = ["og:", "onthebeach:deal:", "onthebeach:hotel:"]
      end
    end

    let(:expected_keys){
      [ "title","description","image","type", "url", "site_name",
        "id",
        "hotel_id",
        "board_code",
        "price",
        "hotel_result_id",
        "board_result_id",
        "flight_result_id" ] }

    it 'returns OnTheBeach meta tags' do
      expect( subject.keys ).to eq(expected_keys)
    end
  end

  describe 'fetch url without og data' do
    let(:url){ 'https://www.onthebeach.co.uk' }
    it "should return a title" do
      expect(subject.keys).to eq(['title'])
    end
  end
end
