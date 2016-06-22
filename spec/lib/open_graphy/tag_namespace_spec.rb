module OpenGraphy
  RSpec.describe TagNamespace do
    let(:tag_namespace) { TagNamespace.new(namespace) }
    let(:namespace) { [] }

    describe '#any?' do
      context 'without any namespaces' do
        let(:namespace) { [] }

        it 'returns false' do
          expect(tag_namespace.any?).to eql(false)
        end
      end

      context 'with the default og namespace' do
        let(:namespace) { ['og'] }

        it 'returns false to avoid namespacing default tags' do
          expect(tag_namespace.any?).to eql(false)
        end
      end

      context 'with some custom namespaces' do
        let(:namespace) { ['product', 'sku'] }

        it 'returns true' do
          expect(tag_namespace.any?).to eql(true)
        end
      end
    end

    describe '#next' do
      it 'returns an instance of TagNamspace' do
        expect(tag_namespace.next).to be_an_instance_of(TagNamespace)
      end

      context 'when there is no additional namespace' do
        let(:namespace) { [] }

        it 'returns a TagNamespace without any items' do
          expect(tag_namespace.next.any?).to eql(false)
        end
      end

      context 'with additional namespaces' do
        let(:namespace) { ['product', 'sku'] }

        it 'returns a TagNamespace with the addtional items' do
          expect(tag_namespace.next.any?).to eql(true)
        end
      end
    end

  end
end
