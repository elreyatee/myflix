class Category < ActiveRecord::Base

  has_many :videos, ->{order(:title)}
  scope :sorted, ->{order(:name)}
  validates :name, presence: true
end