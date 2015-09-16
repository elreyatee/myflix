class AdminController < ApplicationController
  before_action :require_user
  before_action :require_admin

  private

  def require_admin
    unless current_user.admin?
      redirect_to home_path 
      flash[:error] = "You are not authorized to do that"
    end
  end
end