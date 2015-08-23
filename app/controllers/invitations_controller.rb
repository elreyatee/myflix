class InvitationsController < ApplicationController 

  def new

  end

  def create 
    invited_user = create_user
    AppMailer.send_invite_msg(invited_user).deliver
    redirect_to invite_confirmation_path
  end

  def confirm; end

  private

  def create_user
    user = OpenStruct.new
    params.each do |key, value|
      user[key.to_sym] = value
    end
    user
  end
end