class Video < ActiveRecord::Base

  has_many :reviews, ->{ order("created_at DESC") }
  has_many :queue_items, ->{ order(:list_position)}
  belongs_to :category
  scope :sorted, ->{ order(:title) }
  validates_presence_of :title, :description

  def self.search_by_title(title)
    return [] if title.blank?
    self.where("title ILIKE ?", "%#{title}%").order("created_at DESC")
  end

  def average_rating
    return 3.0 if self.reviews.count == 0
    total_score = self.reviews.inject(0) {|sum, review| sum + review.rating}
    total_score / self.reviews.count
  end
end