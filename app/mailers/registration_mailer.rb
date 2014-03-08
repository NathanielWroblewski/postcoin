class RegistrationMailer < ActionMailer::Base

  default from: 'PostCoin <info@postco.in>'

  def welcome(email, generated_password=nil)
    @email = email
    @generated_password = generated_password

    mail(to: @email, subject: 'Account created at PostCoin')
  end
end
