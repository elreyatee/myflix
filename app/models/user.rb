class User < ActiveRecord::Base
  has_secure_password validations: false
  has_many :reviews
  has_many :queue_items, ->{ order(:list_position) }
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: { minimum: 7 }

  def normalize_queue_item_positions
    queue_items.each_with_index do |queue_item, index|
      queue_item.update_attributes(list_position: index + 1)
    end
  end

  def queue_includes?(video)
    self.queue_items.map(&:video).include?(video) 
  end

  def total_queue_items
    queue_items.count
  end

  def total_reviews
    reviews.count
  end
end