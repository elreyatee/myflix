class Admin::VideosController < ApplicationController
  before_action :require_user
  before_action :require_admin

  def new 
    @video = Video.new
    @category_options = Category.all.map { |c| [c.name, c.id] }
  end

  def create
    video = Video.new(video_params)
    video.category = Category.find(params[:video][:category_id])

    if video.save
      flash[:notice] = "Your video has been added"
      redirect_to 'back'
    else
      flash[:error] = "There was an error, please try again"
      render 'new'
    end
  end

  private

  def video_params
    params.require(:video).permit(:title, :description, :large_cover_url, :small_cover_url)
  end

  def require_admin
    unless current_user.admin?
      redirect_to home_path 
      flash[:error] = "You are not authorized to do that"
    end
  end
end
