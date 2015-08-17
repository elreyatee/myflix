class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :video
  scope :sorted, ->{ order(:created_at) }
  validates_presence_of :rating, :body
  validates_uniqueness_of :user_id, 
                          scope: :video_id, 
                          message: "Only one movie review per user"
end