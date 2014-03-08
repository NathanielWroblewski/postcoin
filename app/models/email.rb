class Email < ActiveRecord::Base
  include AmountParsable

  belongs_to :recipient, class_name: 'User'
  belongs_to :sender, class_name: 'User'

  after_create :create_transaction

  def create_transaction
    sender      = User.find_by(email: from)
    recipient   = User.find_or_create_by(email: to)
    amount      = parse(subject)
    # Transaction.new(
    #   private_key: sender.private_key, # < to base58
    #   sender_address: sender.addresses.last,
    #   amount: parse(subject),
    #   recipient_address: recipient.addresses.last
    # )
  end
end
