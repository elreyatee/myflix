class UsersController < ApplicationController
  before_action :require_user, only: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      handle_invitation
      flash[:notice] = 'Your profile has been created!'
      AppMailer.welcome_email(@user).deliver
      redirect_to sign_in_path
    else
      flash[:error] = 'There was a problem, please try again.'
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def new_with_invitation_token
    invitation = Invitation.find_by(invite_token: params[:invite_token])
    if invitation
      @user = User.new(email: invitation.email)
      @invitation_token = invitation.invite_token
      render :new
    else
      redirect_to expired_token_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :name)
  end

  def handle_invitation 
    if params[:invitation_token].present?
      invitation = Invitation.find_by(invite_token: params[:invitation_token])
      @user.follow(invitation.user)
      invitation.user.follow(@user)
      invitation.update_column(:invite_token, nil)
    end
  end
end