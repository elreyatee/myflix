require 'spec_helper'

describe Video do
  it { is_expected.to belong_to(:category) }
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to have_many(:reviews).order("created_at DESC") }

  describe "#search_by_title" do
    it "returns an empty array if there is not match" do
      batman = Video.create(title: "Batman", description: "Comic book movie!")
      superman = Video.create(title: "Superman", description: "Super hero movie!")
      expect(Video.search_by_title("oops")).to eq([])
    end

    it "returns an array of one video for an exact match" do
      batman = Video.create(title: "Batman", description: "Comic book movie!")
      expect(Video.search_by_title("Batman")).to eq([batman])
    end

    it "returns an array of one video for a partial match" do
      batman = Video.create(title: "Batman", description: "Comic book movie!")
      expect(Video.search_by_title("bat")).to eq([batman])
    end

    it "returns an array of all matches ordered by created_at" do
      batman = Video.create(title: "Batman", description: "Comic book movie!")
      superman = Video.create(title: "Superman", description: "Super hero movie!")
      expect(Video.search_by_title("man")).to eq([superman, batman])
    end

    it "returns an empty array for a search with an empty string" do
      batman = Video.create(title: "Batman", description: "Comic book movie!")
      superman = Video.create(title: "Superman", description: "Super hero movie!")
      expect(Video.search_by_title("")).to eq([])
    end
  end

  describe "average_rating" do
    it "returns average of all total rating score" do
      user1 = Fabricate(:user)
      user2 = Fabricate(:user)
      video = Fabricate(:video)
      review1 = Fabricate(:review, rating: 5.0, video: video, user: user1)
      review2 = Fabricate(:review, rating: 5.0, video: video, user: user2)
      expect(video.average_rating).to eq(5.0)
    end
  end
end
