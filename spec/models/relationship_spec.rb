require 'spec_helper'

describe Relationship do 
  it { should belong_to(:user) }
  it { should belong_to(:following) }
  it do 
    should validates(:cannot_follow_self).
    with_message('You cannot follow yourself')
  end
  it do 
    should validate_uniqueness_of(:following_id).
    scoped_to(:user_id).
    with_message('You are already following this user')
  end
end