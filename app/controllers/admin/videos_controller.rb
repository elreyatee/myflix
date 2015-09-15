class Admin::VideosController < ApplicationController
  before_action :require_user
  before_action :require_admin

  def new 
    @video = Video.new
    @category_options = Category.all.map { |c| [c.name, c.id] }
  end

  def create
    @video = Video.new(video_params)

    if @video.save
      flash[:notice] = "Your successfully added #{@video.title}"
      redirect_to new_admin_video_path
    else
      flash[:error] = "There was an error, please try again"
      render 'new'
    end
  end

  private

  def video_params
    params.require(:video).permit(:title, :description, :category_id, :large_cover_url, :small_cover_url)
  end

  def require_admin
    unless current_user.admin?
      redirect_to home_path 
      flash[:error] = "You are not authorized to do that"
    end
  end
end
