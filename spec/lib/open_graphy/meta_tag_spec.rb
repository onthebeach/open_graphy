module OpenGraphy
  RSpec.describe MetaTag do
    let(:meta_tag) { MetaTag.new(doc, meta_tag_element) }
    let(:doc) { double('MokogiriDoc') }
    let(:meta_tag_element) { double('MokogiriElement') }

    describe '#valid?' do
      subject { meta_tag.valid? }

      context 'when the tag exists in the metatag list' do
        before do
          allow(meta_tag_element).to receive(:attr).
            with('property').and_return('og:title')
        end

        it { should be_truthy }
      end

      context 'tag is not in the metatag list' do
        before do
          allow(meta_tag_element).to receive(:attr).
            with('property').and_return('unidentified_tag_name')
        end

        it { should be_falsy }
      end
    end

    describe '#name' do
      before do
        allow(meta_tag_element).to receive(:attr).
          with('property').and_return('og:title')
      end

      it 'returns the tag name withouth the prefix' do
        expect(meta_tag.name).to eql('title')
      end
    end

    describe '#value' do
      before do
        allow(meta_tag_element).to receive(:attr).
          with('content').and_return('Open Graph protocol is great!')
      end

      it 'returns the tag value' do
        expect(meta_tag.value).to eql('Open Graph protocol is great!')
      end
    end
  end
end
