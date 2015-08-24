class InvitationsController < ApplicationController 
  before_action :require_user, only: [:new, :create]

  def new
    @invitation = Invitation.new
  end

  def create 
    @invitation = current_user.invitations.new(recipient_params)
    redirect_to invite_path
  end

  private 

  def recipient_params
    params.require(:invitation).permit!(:name, :email, :message)
  end 
end