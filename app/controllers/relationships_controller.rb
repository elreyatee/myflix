class RelationshipsController < ApplicationController
  before_action :require_user, only: [:create, :destroy, :show]

  def show
    @followings = current_user.followings
  end

  def create
    @relationship = current_user.relationships.build(following_id: params[:following_id])
    if @relationship.save
      flash[:notice] = "You are now following #{User.find(@relationship.following_id).name}"
      redirect_to root_path
    else
      flash[:error] = "Sorry there was a problem"
      redirect_to root_path
    end
  end

  def destroy
    @relationship = current_user.relationships.find_by(following_id: params[:id])
    @relationship.destroy
    flash[:notice] = "You are no longer following #{User.find(@relationship.following_id).name}"
    redirect_to current_user
  end
end