require 'spec_helper'

describe User do  
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:email) }
  it { should have_many(:queue_items).order(:list_position) }

  describe "#queue_includes?" do  

    it "returns true when the user queues the video" do
      user = Fabricate(:user)
      video = Fabricate(:video)  
      Fabricate(:queue_item, user: user, video: video)
      expect(user.queue_includes?(video)).to be_truthy
    end

    it "returns false when the user hasn't queued the video" do 
      user = Fabricate(:user)
      video = Fabricate(:video)  
      expect(user.queue_includes?(video)).to be_falsey
    end
  end
end