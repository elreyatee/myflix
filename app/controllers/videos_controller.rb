class VideosController < ApplicationController

  def front; end
  
  def index
    @categories = Category.order(:name)
  end

  def show 
    @video = Video.find_by(id: params[:id])
  end

  def search
    @results = Video.search_by_title(params[:search_term])
  end
end