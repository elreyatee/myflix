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

  def destroy
    queue_item = QueueItem.find(params[:id])
    queue_item.destroy if current_user.queue_items.include?(queue_item)
    
    subsequent_queue_items = QueueItem.where("list_position > :position", position: params[:id]).
                                       where(user: current_user)
    subsequent_queue_items.map do |item| 
      position = item.list_position
      item.update(list_position: position - 1)
    end
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
