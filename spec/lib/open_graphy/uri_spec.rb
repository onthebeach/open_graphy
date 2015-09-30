require 'spec_helper'

describe OpenGraphy do
  subject {
    VCR.use_cassette('pinterest/pin') do
      OpenGraphy::Uri.open('http://uk.pinterest.com/pin/384213411933800344/')
    end
  }

  describe '#open' do
    context 'with a good url' do
      it 'should redirect and return a response' do
        expect(subject).to include('<meta property="og:site_name" content="Pinterest">')
      end
    end

    context 'with a bad url' do
      it 'should throw a BadUriError' do
        expect{OpenGraphy::Uri.fetch('/title/test/')}.to raise_error(OpenGraphy::Uri::BadUriError)
      end
    end
  end
end
