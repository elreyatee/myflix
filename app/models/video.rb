class Video < ActiveRecord::Base

  belongs_to :category
  scope :sorted, ->{order(:title)}
  validates_presence_of :title, :description

  def self.search_by_title(title)
    return [] if title.blank?
    self.where("title ILIKE ?", "%#{title}%").order("created_at DESC")
  end
end