class User < ActiveRecord::Base
  has_secure_password validations: false
  has_many :relationships
  has_many :followings, through: :relationships
  has_many :reviews
  has_many :queue_items, ->{ order(:list_position) }
  has_many :invitations
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, on: [:create, :update], length: { minimum: 7 }

  def normalize_queue_item_positions
    queue_items.each_with_index do |queue_item, index|
      queue_item.update_attributes(list_position: index + 1)
    end
  end

  def admin?
    admin == true ? true : false
  end

  def queue_includes?(video)
    queue_items.map(&:video).include?(video) 
  end

  def total_queue_items
    queue_items.count
  end

  def total_reviews
    reviews.count
  end

  def total_followers
    Relationship.where(following_id: id).count
  end

  def follow(another_user)
    relationships.create(following_id: another_user.id)
  end 

  def following?(another_user)
    followings.include?(another_user)
  end

  def generate_token
    update_column(:password_reset_token, SecureRandom.urlsafe_base64) #bypasses pw validations
  end
end