require 'spec_helper'

describe User do 
  let(:user) { Fabricate(:user) }
  let(:follower) { Fabricate(:user) }
  let(:video) { Fabricate(:video) }

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:email) }
  it { should have_many(:queue_items).order(:list_position) }
  it { should have_many(:relationships) }
  it { should have_many(:followings).through(:relationships) }

  it "generates a random token when user is created" do 
    aaron = Fabricate(:user)
    expect(aaron.token).to be_present
  end

  describe "#queue_includes?" do  
    it "returns true when the user queues the video" do
      Fabricate(:queue_item, user: user, video: video)
      expect(user.queue_includes?(video)).to be_truthy
    end

    it "returns false when the user hasn't queued the video" do  
      expect(user.queue_includes?(video)).to be_falsey
    end
  end

  describe "#total_queue_items" do 
    it "returns total count of videos in user's queue" do 
      Fabricate(:queue_item, user: user, video: video)
      expect(user.total_queue_items).to eq(1)
    end
  end 

  describe "#total_reviews" do 
    it "returns total count of reviews" do 
      Fabricate(:review, rating: 3.0, video_id: video.id, user_id: user.id)
      expect(user.total_reviews).to eq(1)
    end
  end

  describe "#total_followers" do 
    it "returns total count of user's followers" do 
      Relationship.create(user_id: follower.id, following_id: user.id)
      expect(user.total_followers).to eq(1)
    end
  end

  describe "#following?" do 
    it "returns true of user is following another user" do 
      Relationship.create(user_id: follower.id, following_id: user.id)
      expect(follower.following?(user)).to be_truthy
    end

    it "returns false if user is not following another user" do 
      aaron = Fabricate(:user)
      expect(aaron.following?(user)).to be_falsey
    end
  end
end