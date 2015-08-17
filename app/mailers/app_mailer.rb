class AppMailer < ActionMailer::Base
  def welcome_email(user)
    @user = user
    mail from: 'info@myflixapp.com', to: user.email, subject: "Welcome to MyFlix!"
  end
end