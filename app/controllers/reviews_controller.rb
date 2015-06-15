class ReviewsController < ApplicationController

  def create
    @review = Review.new(review_params)

    if @review.save
      flash[:notice] = "Review submitted."
      redirect_to :back
    else
      flash[:error] = "There was a problem, please try again."
      redirect_to :back
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :body)
  end
end