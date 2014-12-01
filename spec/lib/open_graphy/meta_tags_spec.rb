require 'spec_helper'
describe OpenGraphy::MetaTags do
  let(:meta_tags) { OpenGraphy::MetaTags.new }

  describe '#add' do
    context 'with a title' do
      before do
        meta_tags.add('title', 'Laguna Park II, Tenerife')
      end

      it 'has a title' do
        expect(meta_tags.title?).to be(true)
      end

      it 'returns the title' do
        expect(meta_tags.title).to eql('Laguna Park II, Tenerife')
      end
    end

    context 'without a title but with a page title' do
      before do
        meta_tags.add('__html_title_tag', 'Laguna Park Hotel')
      end

      it 'has a title' do
        expect(meta_tags.title?).to be(true)
      end

      it 'sets the title as the page title' do
        expect(meta_tags.title).to eql('Laguna Park Hotel')
      end
    end

    context 'with an image' do
      before do
        meta_tags.add('image', 'foo.jpg')
      end

      it 'has an image' do
        expect(meta_tags.image?).to be(true)
      end

      it 'returns the image url' do
        expect(meta_tags.image).to eql('foo.jpg')
      end
    end

    context 'without a description' do
      it 'has no description' do
        expect(meta_tags.description?).to be(false)
      end
    end
  end
end
