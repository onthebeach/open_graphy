require 'spec_helper'

describe OpenGraphy do

  describe OpenGraphy::Configuration do
    before do
      OpenGraphy.configure do |config|
        config.metatags = ['og:', 'onthebeach:deal:', 'onthebeach:hotel:']
        config.user_agent = 'OpenGraphyBot'
      end
    end

    describe '#metatags' do
      let(:expected_tags){ ['og:', 'onthebeach:deal:', 'onthebeach:hotel:'] }
      it{ expect(OpenGraphy.configuration.metatags).to eq(expected_tags) }
    end

    describe '#user_agent' do
      it 'returns the user agent' do
        expect(OpenGraphy.configuration.user_agent).to eq('OpenGraphyBot')
      end
    end
  end
end
