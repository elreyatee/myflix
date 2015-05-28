class Video < ActiveRecord::Base

  belongs_to :category
  scope :sorted, ->{order(:title)}
  validates :title, presence: true
  validates :description, presence: true
end