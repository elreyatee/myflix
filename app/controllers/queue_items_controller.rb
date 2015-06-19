class QueueItemsController < ApplicationController
  before_action :require_user

  def index 
    @queue_items = current_user.queue_items
  end

  def create
    video = Video.find(params[:id])
    queue_video(video)
    redirect_to my_queue_path
  end

  private

  def video_in_queue?(video)
    QueueItem.where(video: video, user: current_user).first
  end

  def queue_video(video)
    QueueItem.create(user: current_user, video: video, list_position: current_user.queue_items.count + 1) unless video_in_queue?(video)
  end
end
