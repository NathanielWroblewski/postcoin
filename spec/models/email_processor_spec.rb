require 'spec_helper'

describe EmailProcessor, 'process' do
  it 'creates an email for each recipient' do
    email = create(:email)

    EmailProcessor.process(email)

    sent_email = Email.last
    expect(sent_email.to).to eq email.to.first[:email]
    expect(sent_email.from).to eq email.from
    expect(sent_email.subject).to eq email.subject
  end
end
