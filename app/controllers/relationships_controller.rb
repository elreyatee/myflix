class RelationshipsController < ApplicationController
  before_action :require_user, only: [:create, :destroy, :index]

  def index
    @followings = current_user.followings
  end

  def create
    @relationship = current_user.relationships.create(following_id: params[:following_id])
    followed_user = User.find(@relationship.following_id)

    if @relationship.errors.any?
      @relationship.errors.messages.values.each do |msg|
        flash[:error] = "#{msg.first}"
        redirect_to :back
      end
    else
      flash[:notice] = "You are now following #{followed_user.name}"
      redirect_to relationships_path(current_user)
    end
  end

  def destroy
    relationship = current_user.relationships.find_by(following_id: params[:id])
    followed_user = User.find(relationship.following_id)
    relationship.destroy
    flash[:notice] = "You are no longer following #{followed_user.name}"
    redirect_to relationships_path(current_user)
  end
end