require 'spec_helper'

describe OpenGraphy do

  describe OpenGraphy::Configuration do
    before do
      OpenGraphy.configure do |config|
        config.metatags = ["og:", "onthebeach:deal:", "onthebeach:hotel:"]
      end
    end

    describe '#metatags' do
      let(:expected_tags){ ["og:", "onthebeach:deal:", "onthebeach:hotel:"] }
      it{ expect(OpenGraphy.configuration.metatags).to eq(expected_tags) }
    end
  end
end
