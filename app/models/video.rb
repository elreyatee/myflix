class Video < ActiveRecord::Base

  has_many :reviews, ->{ order("created_at DESC") }
  has_many :queue_items, ->{ order(:list_position) }
  belongs_to :category
  scope :sorted, ->{ order(:title) }
  validates_presence_of :title, :description
  mount_uploader :small_cover_url, CoverUploader
  mount_uploader :large_cover_url, CoverUploader

  def self.search_by_title(title)
    return [] if title.blank?
    self.where("title ILIKE ?", "%#{title}%").order("created_at DESC")
  end

  def average_rating
    self.reviews.average(:rating).round(2) unless self.reviews.count == 0
  end
end