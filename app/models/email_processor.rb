class EmailProcessor < ActiveRecord::Base

  def self.process(email)
    if sender = User.find_by(email: email.from)
      email.to.each do |recipient|
        next if recipient[:email].include?('cc@postco.in')
        receiver = User.find_or_create_by(email: recipient[:email])
        Email.create(
          to: recipient[:email],
          from: email.from,
          subject: email.subject,
          sender_id: sender.id,
          recipient_id: receiver.id
        )
      end
    end
  end
end
