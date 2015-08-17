require 'spec_helper'

describe Review do 
  it { should belong_to(:user) }
  it { should belong_to(:video) }
  it { should validate_presence_of(:rating) }
  it { should validate_presence_of(:body) }
  it do 
    should validate_uniqueness_of(:user_id).
    scoped_to(:video_id).
    with_message('Only one movie review per user')
  end
end