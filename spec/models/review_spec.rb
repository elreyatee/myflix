require 'spec_helper'

describe Review do 
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:video) }
  it { is_expected.to validate_presence_of(:rating) }
  it { is_expected.to validate_presence_of(:body) }
  it do 
    is_expected.to validate_uniqueness_of(:user_id).
    scoped_to(:video_id).
    with_message('Only one movie review per user')
  end

  it "reviews should be in order by creation" do 
    video = Fabricate(:video)
    review1 = Fabricate(:review, user: Fabricate(:user), video: video)
    review2 = Fabricate(:review, user: Fabricate(:user), video: video)
  end
end