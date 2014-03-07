require 'spec_helper'

describe Bitstamp, '.latest' do
  let(:response) { { 'last' => '625.01' } }

  it 'returns the latest from bitstamp' do
    HTTParty.stub(:get).and_return(response)

    result = Bitstamp.latest

    expect(HTTParty).to have_received(:get).with('https://www.bitstamp.net/api/ticker/')
    expect(result).to eq 625.01
  end
end
