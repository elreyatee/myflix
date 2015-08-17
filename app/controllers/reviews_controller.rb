class ReviewsController < ApplicationController
  before_action :require_user

  def create
    @video = Video.find(params[:video_id])
    review = @video.reviews.create(review_params.merge!(user: current_user))
    if review.errors.any?
      review.errors.messages.values.each do |msg|
        flash[:error] = "#{msg.first}"
        @reviews = @video.reviews.reload
        render "videos/show"
      end
    else
      redirect_to @video
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :body)
  end
end