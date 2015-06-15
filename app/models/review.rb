class Review < ActiveRecord::Base

  belongs_to :user
  belongs_to :video
  scope :sorted, ->{ order(:created_at) }
  validates_presence_of :rating, :body
  # validates_uniqueness_of :user_id, scope: :video_id, 
  #   message: "One user review per movie"
end