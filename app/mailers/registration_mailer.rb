class RegistrationMailer < ActionMailer::Base

  default from: 'PostCoin <cc@postco.in>'

  def welcome(user_id, generated_password=nil)
    @user = User.find(user_id)
    @generated_password = generated_password

    mail(to: @user.email, subject: 'Account created at PostCoin')
  end
end
