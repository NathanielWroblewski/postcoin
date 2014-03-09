class Email < ActiveRecord::Base
  include AmountParsable

  belongs_to :recipient, class_name: 'User'
  belongs_to :sender, class_name: 'User'

  after_create :create_transaction

  def create_transaction
    sender      = User.find_by(email: from)
    recipient   = User.find_or_create_by(email: to)
    amount      = parse(subject)
    Transaction.new(
      private_key: sender.private_key,
      sender_address: sender.addresses.last.to_s,
      amount: parse(subject),
      recipient_address: recipient.addresses.last,
      unspents: fetch_unspents(sender.addresses.last.to_s)
    )
  end

  def fetch_unspents(address)
    url = "http://#{ENV['HELLOBLOCK_ENV']}.helloblock.io/addresses/#{address}/unspents"
    response = HTTParty.get(url)
    response['data']['unspents'].map do |unspent|
      [unspent['scriptPubKey']].pack('H*')
    end
  end
end
