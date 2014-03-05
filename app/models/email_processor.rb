class EmailProcessor < ActiveRecord::Base

  def self.process(email)
    email.to.each do |recipient|
      Email.create(
        to: recipient[:email],
        from: email.from,
        subject: email.subject,
        body: email.body
      )
    end
  end
end
