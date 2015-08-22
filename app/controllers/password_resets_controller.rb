class PasswordResetsController < ApplicationController
  def show
    user = User.find_by(password_reset_token: params[:id])
    if user
      @password_reset_token = user.password_reset_token
    else
      redirect_to expired_token_path
    end
  end

  def create
    user = User.find_by(password_reset_token: params[:password_reset_token])
    if user && user.update(password: params[:password]) #checks AR validations on password
      user.save
      redirect_to sign_in_path, notice: "Your password has been changed. Please sign in."
    else
      redirect_to expired_token_path
    end
  end

  def expired_token; end
end