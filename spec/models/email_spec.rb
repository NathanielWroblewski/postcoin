require 'spec_helper'

describe Email do
  it_behaves_like AmountParsable
end

describe Email, 'associations' do
  it { expect(subject).to belong_to(:recipient) }
  it { expect(subject).to belong_to(:sender) }

  it 'has a sender and recipient' do
    sender = create(:user)
    recipient = create(:user)

    email = Email.new(sender_id: sender.id, recipient_id: recipient.id)

    expect(email.sender).to eq sender
    expect(email.recipient).to eq recipient
  end
end
