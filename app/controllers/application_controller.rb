class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:error] = 'Please log in.'
      redirect_to sign_in_path
    end
  end
end
