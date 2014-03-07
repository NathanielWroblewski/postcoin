require 'spec_helper'

describe Transaction, '#sufficient_funds?' do
  let(:transaction) { Transaction.new(TEST_TRANSACTION_ATTRS) }

  it 'is true if the sender can afford the amount plus the fee' do
    transaction.stub(:amount).and_return(10_000)     # fee is 10_000
    transaction.stub(:total).and_return(20_000)

    expect(transaction.sufficient_funds?).to eq true
  end

  it 'is false otherwise' do
    transaction.stub(:amount).and_return(10_001)
    transaction.stub(:total).and_return(20_000)

    expect(transaction.sufficient_funds?).to eq false
  end
end

describe Transaction, '#prepare' do
  let(:transaction) { Transaction.new(TEST_TRANSACTION_ATTRS) }
  let(:tx)          { double(:tx).as_null_object }
  let(:unspent)     { double(:unspent).as_null_object }

  before :each do
    transaction.stub(:withdraw)
    transaction.stub(:spend)
    transaction.stub(:unspents).and_return([unspent])
  end

  it 'raises an error if there are insufficient funds' do
    transaction.stub(:amount).and_return(10_001)
    transaction.stub(:total).and_return(20_000)

    expect{transaction.prepare(tx)}.to raise_error(RuntimeError, 'Insufficient funds.')
  end

  it 'withdraws each unspent and spends it if sufficient funds' do
    transaction.stub(:total).and_return(1_000_00)
    transaction.stub(:amount).and_return(1)

    transaction.prepare(tx)

    expect(transaction).to have_received(:withdraw).with(unspent)
    expect(transaction).to have_received(:spend)
  end
end

describe Transaction, '#withdraw' do
  let(:transaction) { Transaction.new(TEST_TRANSACTION_ATTRS) }
  let(:tx)          { double(:tx) }
  let(:input)       { double(:input) }
  let(:private_key) { Bitcoin::Key.from_base58(
                        '92xShwMuSXbHhwvN5X8xHG3pTnftyh5FXMPzbT1XDYRw6a6Vv2q')
                    }
  let(:unspent)     {
    {
      txHash: 'fa069174aa9f122b6226577dd4102cab5364a8904305a93056160761edc1805a',
      index: 0,
      scriptPubKey: ["76a914c641ae0233f58861892a585cd7d3164625c860cf88ac"].pack('H*')
    }
  }

  before :each do
    transaction.stub(:transaction).and_return(tx)
    tx.stub(:input).and_yield(input)
  end

  it 'provides transaction hash, index, script pubkey, and private key' do
    input.stub(:prev_out)
    input.stub(:signature_key)

    transaction.withdraw(unspent)

    expect(input).to have_received(:prev_out).with(
      unspent[:txHash], unspent[:index], unspent[:scriptPubKey]
    )
    expect(input).to have_received(:signature_key).with(private_key)
  end
end

describe Transaction, '#spend' do
  let(:transaction) { Transaction.new(TEST_TRANSACTION_ATTRS) }
  let(:recipient)   { 'mugwYJ1sKyr8EDDgXtoh8sdDQuNWKYNf88' }
  let(:sender)      { 'mybEmYUVLX45ReEpXmJDHYKge7xV9Nq8cv' }
  let(:fee)         { 10_000 }

  before :each do
    transaction.stub(:recipient_address).and_return(recipient)
    transaction.stub(:sender_address).and_return(sender)
  end

  it 'sends bitcoin to the recipient and change to the sender' do
    transaction.stub(:total).and_return(30_000)
    transaction.stub(:amount).and_return(10_000)
    transaction.stub(:send)

    transaction.spend

    expect(transaction).to have_received(:send).with(btc: 10_000, to: recipient)
    expect(transaction).to have_received(:send).with(
      btc: 30_000 - (fee + 10_000), to: sender
    )
  end
end

describe Transaction, '#send' do
  let(:transaction) { Transaction.new(TEST_TRANSACTION_ATTRS) }
  let(:tx)          { double(:tx).as_null_object }
  let(:output)      { double(:output).as_null_object }
  let(:recipient)   { 'mugwYJ1sKyr8EDDgXtoh8sdDQuNWKYNf88' }
  let(:script)      { double(:script).as_null_object }

  before :each do
    transaction.stub(:transaction).and_return(tx)
    tx.stub(:output).and_yield(output)
    output.stub(:script).and_yield(script)
  end

  it 'transfers some value of bitcoin to an address' do
    transaction.send(btc: 100_000, to: recipient)

    expect(output).to have_received(:value).with(100_000)
    expect(script).to have_received(:recipient).with(recipient)
  end
end

describe Transaction, '#initialize' do
  let(:transaction) { double(:transaction).as_null_object }

  it 'explodes unless all attributes are provided' do
    expect{Transaction.new}.to raise_error
  end

  it 'builds a transaction' do
    Transaction.any_instance.stub(:build_tx)

    transaction = Transaction.new(TEST_TRANSACTION_ATTRS)

    expect(transaction).to have_received(:build_tx)
  end
end
