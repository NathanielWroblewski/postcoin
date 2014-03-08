class EmailProcessor < ActiveRecord::Base

  def self.process(email)
    if sender = User.find_by(email: email.from)
      email.to.each do |recipient|
        Email.create(
          to: recipient[:email],
          from: email.from,
          subject: email.subject,
          sender_id: sender.id,
          recipient_id: User.find_or_create_by(email: recipient[:email]).id
        )
      end
    end
  end
end
