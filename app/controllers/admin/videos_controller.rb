class Admin::VideosController < ApplicationController
  def new 
    @category_options = Category.all.map { |c| [c.name, c.id] }
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)
  end

  private

  def video_params
    params.require(:video).permit(:title, :category, :description, :large_cover_url, :small_cover_url)
  end
end
