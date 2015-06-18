class Category < ActiveRecord::Base

  has_many :videos, ->{ order("created_at DESC") }
  scope :sorted, ->{ order(:name) }
  validates_presence_of :name

  def to_param
    self.name
  end

  def recent_videos
    videos.first(6)
  end
end