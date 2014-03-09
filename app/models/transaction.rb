class Transaction
  include Bitcoin::Builder

  attr_accessor :amount, :unspents, :private_key, :sender_address,
                :recipient_address, :transaction, :total

  FEE = 10_000

  def initialize(private_key:, sender_address:, unspents:, amount:, recipient_address:)
    @amount            = amount
    @unspents          = unspents
    @private_key       = private_key
    @sender_address    = sender_address
    @recipient_address = recipient_address
    transaction_hex    = build_tx{ |transaction| prepare transaction }
    binding.pry
    propagate transaction_hex.to_payload.unpack('H*')
  end

  def prepare(transaction)
    @transaction = transaction
    if sufficient_funds?
      unspents.each { |unspent| withdraw unspent } and spend
    else
      raise RuntimeError, 'Insufficient funds.'
    end
  end

  def withdraw(unspent)
    transaction.input do |input|
      input.prev_out(unspent[:txHash], unspent[:index], unspent[:scriptPubKey])
      input.signature_key(private_key)
    end
  end

  def spend
    change = total - (amount + FEE)
    addresses = { recipient_address => amount, sender_address => change }
    addresses.each{ |address, bitcoin| send(btc: bitcoin, to: address) }
  end

  def send(btc:, to:)
    transaction.output do |o|
      o.value(btc)
      o.script{|s| s.recipient(to) }
    end
  end

  def sufficient_funds?
    @total = unspents.map{|unspent| unspent[:value]}.reduce(:+)
    (amount + FEE) <= total
  end

  def propagate(transaction_hex)
    url = "http://testnet.helloblock.io/transactions"
    HTTParty.post(url, body: { rawTxHex: transaction_hex })
  end
end
