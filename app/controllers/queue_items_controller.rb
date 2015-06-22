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

  def update_queue
    begin
      update_queue_items
      normalize_queue_item_positions
    rescue ActiveRecord::RecordInvalid
      flash[:error] = "Invalid position numbers."
    end
    redirect_to my_queue_path
  end

  def destroy
    queue_item = QueueItem.find(params[:id])
    queue_item.destroy if current_user.queue_items.include?(queue_item)
    normalize_queue_item_positions
    redirect_to my_queue_path
  end

  private

  def video_in_queue?(video)
    QueueItem.find_by(video: video, user: current_user)
  end

  def queue_video(video)
    QueueItem.create(user: current_user, video: video, list_position: current_user.queue_items.count + 1) unless video_in_queue?(video)
  end

  def update_queue_items
    ActiveRecord::Base.transaction do
      params[:queue_items].each do |queue_item_data|
        queue_item = QueueItem.find(queue_item_data["id"])
        queue_item.update_attributes!(list_position: queue_item_data["list_position"]) if queue_item.user == current_user
      end
    end
  end

  def normalize_queue_item_positions
    current_user.queue_items.each_with_index do |queue_item, index|
      queue_item.update_attributes(list_position: index + 1)
    end
  end
end
