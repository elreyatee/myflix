require 'spec_helper'

describe QueueItem do  
  it { should belong_to(:user) }
  it { should belong_to(:video) }
  it { should validate_numericality_of(:list_position).only_integer }

  describe "#title" do
    it "returns the title of the associated video" do  
      video = Fabricate(:video, title: 'Daredevil')
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.video_title).to eq('Daredevil')
    end
  end

  describe "#rating" do
    it "returns the rating from the review when the review is present" do
      video = Fabricate(:video)
      user = Fabricate(:user)
      review = Fabricate(:review, user: user, video: video, rating: 4.0)
      queue_item = Fabricate(:queue_item, user: user, video: video)
      expect(queue_item.rating).to eq(4.0)
    end

    it "returns nil when the review is not present" do
      video = Fabricate(:video)
      user = Fabricate(:user)
      queue_item = Fabricate(:queue_item, user: user, video: video)
      expect(queue_item.rating).to eq(nil)
    end
  end

  describe "#category" do
    it "reutrns the category's name of the video" do
      category = Fabricate(:category, name: "Action")
      video = Fabricate(:video, category: category)
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.category_name).to eq("Action")
    end
  end

  describe "#category" do
    it "returns the category of the video" do  
      category = Fabricate(:category, name: "Action")
      video = Fabricate(:video, category: category)
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.category).to eq(category)
    end
  end
end