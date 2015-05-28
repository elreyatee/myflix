class VideosController < ApplicationController
  def index
    # @videos = Video.all
    @categories = Category.all.sort_by {|c| c.name}
  end

  def show 
    @video = Video.find_by(id: params[:id])
  end
end