require 'spec_helper'

describe OpenGraphy::Uri::Fetcher do
  describe '#fetch' do
    let(:fetcher) { OpenGraphy::Uri::Fetcher.new(uri) }
    let(:uri) { 'https://www.onthebeach.co.uk/test' }
    let(:port) { 443 }

    let(:http) { double('HTTP') }
    let(:request) {
      double(
        'Request',
        value: 'test',
      )
    }

    before do
      allow(Net::HTTP).to receive(:new).
        with('www.onthebeach.co.uk', port).
        and_return(http)

      allow(Net::HTTP::Get).to receive(:new).
        with('/test', { 'User-Agent' => 'OpenGraphyBot' }).
        and_return(request)

      allow(request).to receive(:initialize_http_header)

      allow(http).to receive(:request).
        with(request).
        and_return(request)
    end

    it 'uses ssl when the scheme is https' do
      expect(http).to receive(:use_ssl=).with(true)

      fetcher.fetch
    end

    context 'with non ssl url' do
      let(:uri) { 'http://www.onthebeach.co.uk/test' }
      let(:port) { 80 }

      it 'uses ssl when the scheme is https' do
        expect(http).to receive(:use_ssl=).with(false)

        fetcher.fetch
      end
    end
  end
end
