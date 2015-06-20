require 'spec_helper'

describe Category do 
  it { should have_many(:videos) }
  it { should validate_presence_of :name }

  describe "recent_videos" do
    it "returns videos in reverse chonological order by created at" do
      action = Category.create(name: "Action")
      ironman = Video.create(title: "Ironman", description: "Hero movie", category: action, created_at: 1.day.ago)
      spiderman = Video.create(title: "Spiderman", description: "Hero movie", category: action)
      expect(action.recent_videos).to eq([spiderman, ironman])
    end

    it "returns all the videos if total is less than 6" do
      action = Category.create(name: "Action")
      ironman = Video.create(title: "Ironman", description: "Hero movie", category: action, created_at: 1.day.ago)
      spiderman = Video.create(title: "Spiderman", description: "Hero movie", category: action)
      expect(action.recent_videos.count).to eq(2)
    end

    it "returns 6 videos if total is more than 6" do
      action = Category.create(name: "Action")
      10.times { Video.create(title: "Spiderman", description: "Hero movie", category: action) }
      expect(action.recent_videos.count).to eq(6)
    end

    it "returns the most recent 6 videos" do
      action = Category.create(name: "Action")
      10.times { Video.create(title: "Spiderman", description: "Hero movie", category: action) }
      hulk = Video.create(title: "Hulk", description: "Hero movie", category: action, created_at: 1.day.ago)

      expect(action.recent_videos).not_to include(hulk)
    end

    it "return empty array if Category has no videos" do
      action = Category.create(name: "Action")
      expect(action.recent_videos).to eq([])
    end

  end
end