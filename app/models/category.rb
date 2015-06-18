class Category < ActiveRecord::Base

  has_many :videos, ->{ order("created_at DESC") }
  scope :sorted, ->{ order(:name) }
  validates :name, presence: true

  def to_param
    self.name
  end

  def recent_videos
    videos.first(6)
  end
end