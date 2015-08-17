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

  it "reviews should be in order by creation" do 
    video = Fabricate(:video)
    review1 = Fabricate(:review, user: Fabricate(:user), video: video)
    review2 = Fabricate(:review, user: Fabricate(:user), video: video)
  end
end