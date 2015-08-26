class Invitation < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :name, :email, :message, :user_id
  validates_uniqueness_of :email

  before_create :generate_token

  def generate_token
    self.invite_token = SecureRandom.urlsafe_base64
  end
end