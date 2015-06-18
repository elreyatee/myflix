class QueueItemsController < ApplicationController
  before_action :require_user

  def index 
    @queue_items = current_user.queue_items
  end

  def update
    @video = Video.find(params[:id])
    add_to_queue(@video) unless video_in_queue?(@video)
    flash[:notice] = "Your video has been added to the queue."
    redirect_to @video
  end

  private

  def video_in_queue?(video)
    QueueItem.where(video_id: video.id, user_id: current_user.id).first
  end

  def add_to_queue(video)
    QueueItem.create(user_id: current_user.id, video_id: video.id, list_position: current_user.queue_items.count + 1)
  end
end
