class ForgotPasswordsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:email])
    if user
      user.generate_token
      AppMailer.delay.send_forgot_password(user.id)
      redirect_to forgot_password_confirmation_path
    else
      flash[:error] = params[:email].blank? ? "Email cannot be blank" : "There is not user with that email in the system"
      redirect_to forgot_password_path
    end
  end

  def confirm; end
end