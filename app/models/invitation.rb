class Invitation < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :name, :email, :message
  validates_uniqueness_of :email
end