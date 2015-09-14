class Admin::VideosController < AdminController
  def new 
    @category_options = Category.all.map { |c| [c.name, c.id] }
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)

    if @video.save
      flash[:notice] = "Your video has been added"
      redirect_to 'back'
    else
      flash[:error] = "There was an error, please try again"
      render 'new'
    end
  end

  private

  def video_params
    params.require(:video).permit(:title, :category, :description, :large_cover_url, :small_cover_url)
  end
end
