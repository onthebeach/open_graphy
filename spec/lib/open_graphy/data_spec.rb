require 'spec_helper'
describe OpenGraphy::Data, :vcr  do
  subject{ OpenGraphy.fetch(url) }
  let(:url){ 'http://www.imdb.com/title/tt2084970/?ref_=inth_ov_tt' }

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

  describe '#keys' do
    let(:expected_keys) {
      [
        "url", "image", "type", "title",
        "site_name", "description", "__html_title_tag"
      ]
    }

    it 'should be able to return the keys of the object' do
      expect(subject.keys).to eq(expected_keys)
    end
  end
end
