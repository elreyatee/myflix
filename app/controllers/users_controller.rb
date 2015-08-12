class UsersController < ApplicationController
  before_action :require_user, only: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = 'Your profile has been created!'
      redirect_to sign_in_path
    else
      flash[:error] = 'There was a problem, please try again.'
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def follow

  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :name)
  end
end