require 'spec_helper'

describe 'A transaction' do
  it 'works' do
    response = HTTParty.get('http://testnet.helloblock.io/faucet?type=1')['data']
    private_key = response['privateKeyBase58Uncompressed']
    sender_address = response['address']
    unspents = response['unspents'].map do |unspent|
      unspent['scriptPubKey'] = [unspent['scriptPubKey']].pack('H*')
      unspent
    end

    transaction = Transaction.new(
      private_key: Bitcoin::Key.from_base58(private_key),
      sender_address: sender_address,
      unspents: unspents,
      amount: 10_000,
      recipient_address: Bitcoin.generate_address[0]
    )

    expect(transaction['status']).to eq 'success'
  end
end
