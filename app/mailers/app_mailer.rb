class AppMailer < ActionMailer::Base
  default from: 'info@myflixapp.com'
  
  def welcome_email(user)
    @user = user
    mail to: user.email, subject: "Welcome to MyFlix!"
  end

  def send_forgot_password(user)
    @token = user.token
    mail to: user.email, subject: "Please reset your password"
  end
end