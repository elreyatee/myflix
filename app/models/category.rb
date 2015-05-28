class Category < ActiveRecord::Base

  has_many :videos, ->{order(:title)}
  scope :sorted, ->{order(:name)}
  validates :name, presence: true

  def to_param
    self.name
  end
end