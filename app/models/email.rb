class Email < ActiveRecord::Base
  after_create :create_transaction

  def create_transaction
    # Transaction.new
  end
end
