require 'spec_helper'

describe Relationship do 
  it { should belong_to(:user) }
  it { should belong_to(:following) }
  it { should validate_presence_of(:following_id) }
  it { should validate_presence_of(:user_id) }
  it do 
    should validate_uniqueness_of(:following_id).
    scoped_to(:user_id).
    with_message('You are already following this user')
  end

  it "should not allow user to follow themselves" do
    user = Fabricate(:user)
    @relationship = Relationship.create(following_id: user.id, user_id: user.id)
    expect(@relationship.errors.full_messages).to include("You cannot follow yourself")
  end
end