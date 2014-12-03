require 'spec_helper'

describe OpenGraphy do
  subject {
    VCR.use_cassette('pinterest/pin', :record => :new_episodes) do
      OpenGraphy::Uri.open('http://uk.pinterest.com/pin/384213411933800344/')
    end
  }

  describe '#open' do
    it 'should redirect and return a response' do
      expect(subject).to include('<meta property="og:site_name" content="Pinterest">')
    end
  end
end
