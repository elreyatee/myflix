class InvitationsController < ApplicationController 
  before_action :require_user, only: [:new, :create]

  def new
    @invitation = Invitation.new
  end

  def create 
    @invitation = current_user.invitations.new(recipient_params)
    if @invitation.save
      AppMailer.delay.send_invite(@invitation.id)
      flash[:notice] = "You have successfully invited #{@invitation.name}"
      redirect_to new_invitation_path
    else
      flash[:error] = "Invitation not sent, please check your inputs"
      render :new
    end
  end

  private 

  def recipient_params
    params.require(:invitation).permit(:name, :email, :message)
  end 
end