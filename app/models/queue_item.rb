class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  delegate :category, to: :video
  delegate :title, to: :video, prefix: :video
  validates_numericality_of :list_position, { only_integer: true }

  def rating
    review = Review.find_by(user: user, video: video)
    review.rating if review
  end

  def category_name
    category.name
  end 
end