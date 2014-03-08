share_examples_for AmountParsable do
  before(:all) do
    @model = described_class.new
  end

  describe '#parse' do
    let(:model) { @model }

    before :each do
      Bitstamp.stub(:latest).and_return(677.11)
    end

    it 'converts mBTC suffixed amounts into satoshis' do
      subject = '200 mBTC'

      expect(model.parse(subject)).to eq 20_000_000
    end

    it 'converts mBTC prefixed amounts into satoshis' do
      subject = 'mBTC 200'

      expect(model.parse(subject)).to eq 20_000_000
    end

    it 'converts BTC suffixed amounts into satoshis' do
      subject = '200 BTC'

      expect(model.parse(subject)).to eq 20_000_000_000
    end

    it 'converts BTC prefixed amounts into satoshis' do
      subject = 'BTC 200'

      expect(model.parse(subject)).to eq 20_000_000_000
    end

    it 'converts bitcoin suffixed amounts into satoshis' do
      subject = '200 bitcoin'

      expect(model.parse(subject)).to eq 20_000_000_000
    end

    it 'converts ฿ prefixed amounts into satoshis' do
      subject = '฿ 200'

      expect(model.parse(subject)).to eq 20_000_000_000
    end

    it 'converts ฿ prefixed amounts into satoshis' do
      subject = '฿200'

      expect(model.parse(subject)).to eq 20_000_000_000
    end

    it 'converts USD suffixed amounts into satoshis' do
      subject = '200 USD'

      expect(model.parse(subject)).to eq 29537298
    end

    it 'converts USD suffixed amounts into satoshis' do
      subject = '$ 200'

      expect(model.parse(subject)).to eq 29537298
    end

    it 'converts USD suffixed amounts into satoshis' do
      subject = '$200'

      expect(model.parse(subject)).to eq 29537298
    end

    it 'converts USD suffixed amounts into satoshis' do
      subject = '200 dollar'

      expect(model.parse(subject)).to eq 29537298
    end
  end
end
