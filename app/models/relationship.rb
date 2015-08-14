class Relationship < ActiveRecord::Base
  belongs_to :user
  belongs_to :following, class_name: "User"
  validates_uniqueness_of :following_id, scope: :user_id, 
    message: "You are already following this user"
  validate :cannot_follow_self

  def cannot_follow_self
    errors.add(:base, "You cannot follow yourself") if user == following
  end
end