class SessionsController < ApplicationController
  
  def new
    redirect_to home_path if logged_in?
  end

  def create
    user = User.where(email: params[:email]).first

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = 'You are signed in.'
      redirect_to home_path
    else
      flash[:error] = 'Invalid email or password.'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'You are signed out.'
    redirect_to root_path
  end
end