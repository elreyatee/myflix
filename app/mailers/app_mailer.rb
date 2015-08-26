class AppMailer < ActionMailer::Base
  default from: 'info@myflixapp.com'
  
  def welcome_email(user)
    @user = user
    mail to: user.email, subject: "Welcome to MyFlix!"
  end

  def send_forgot_password(user)
    @user = user
    mail to: user.email, subject: "Please reset your password"
  end

  def send_invite(invitation)
    @invitation = invitation
    mail to: invitation.email, subject: "Invitation to join MyFlix!"
  end
end