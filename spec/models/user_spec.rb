require 'spec_helper'

describe User, 'associations' do
  it { expect(subject).to have_many(:addresses) }
  it { expect(subject).to have_many(:sent_emails) }
  it { expect(subject).to have_many(:received_emails) }

  it 'has many sent and received emails' do
    Email.any_instance.stub(:create_transaction)
    user = create(:user)
    recipient = create(:user)
    received_email = Email.create(recipient_id: user.id, subject: '$10', to: user.email)
    sent_email = Email.create(sender_id: user.id, subject: '$10', to: 'blah@blah.com')

    expect(user.sent_emails).to include sent_email
    expect(user.received_emails).to include received_email
  end
end

describe User, 'validations' do
  before(:each) { RegistrationMailer.stub_chain(:welcome, :deliver) }

  it { expect(subject).to validate_presence_of(:email) }
end

describe User, '#generate_keys' do
  let(:keys) { ['570c28416fdb738c0941497bc59f95c157c6037d66c7185d162883cd9b497a21',
                '04f3f17c53ef02dbf95d642b79e9390820c46456309c096429c7b7d15b4d' +
                '87d001b3f6452057840d3412e645158d71e590d485437a92b9c345e1c9c1' +
                'bd3331ba13'] }

  it 'generates a private and public key' do
    user = build(:user)
    Bitcoin.stub(:generate_key).and_return(keys)

    user.generate_keys

    expect(user.private_key).to eq keys.first
    expect(user.public_key).to eq keys.last
  end

  it 'is called on create' do
    user = build(:user)
    user.stub(:generate_keys)

    user.save

    expect(user).to have_received(:generate_keys)
  end
end
