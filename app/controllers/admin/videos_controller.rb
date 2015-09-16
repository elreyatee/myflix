class Admin::VideosController < AdminController
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
    params.require(:video).permit(:title, :description, :category_id, :video_url, :large_cover, :small_cover)
  end
end
