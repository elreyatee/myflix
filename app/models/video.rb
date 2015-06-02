class Video < ActiveRecord::Base

  belongs_to :category
  scope :sorted, ->{order(:title)}
  validates_presence_of :title, :description
end