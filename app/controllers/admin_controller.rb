class AdminController < ApplicationController
  before_action :require_user
  before_action :require_admin

  def require_admin
    redirect_to sign_in_path unless current_user.admin? 
  end
end