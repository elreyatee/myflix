class AppMailer < ActionMailer::Base
  default from: 'info@myflixapp.com'
  
  def welcome_email(user_id)
    @user = User.find(user_id)
    mail to: @user.email, subject: "Welcome to MyFlix!"
  end

  def send_forgot_password(user_id)
    @user = User.find(user_id)
    mail to: @user.email, subject: "Please reset your password"
  end

  def send_invite(invitation_id)
    @invitation = Invitation.find(invitation_id)
    mail to: @invitation.email, subject: "Invitation to join MyFlix!"
  end
end