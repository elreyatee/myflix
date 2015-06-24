require 'spec_helper'

describe VideosController do
  before { set_current_user }

  let(:video) { Fabricate(:video) }

  describe "GET show" do
    it "assigns @video with authenticated users" do
      get :show, id: video.id
      expect(assigns(:video)).to eq(video)
    end

    it "sets @reviews for authenticated users" do
      video = Fabricate(:video)
      review1 = Fabricate(:review, video: video)
      review2 = Fabricate(:review, video: video)
      get :show, id: video.id
      expect(assigns(:reviews)).to match_array [review1, review2]
    end

    it "sets the @review variable for authenticated users" do
      get :show, id: video.id
      expect(assigns(:review)).to be_instance_of Review
    end

    it_behaves_like "require_sign_in" do  
      let(:action) { get :show, id: video.id }
    end
  end

  describe "GET search" do
    it "assigns @results with authenticated users" do
      raid = Fabricate(:video, title: "Raid", description: "An action movie!")
      get :search, search_term: 'raid'
      expect(assigns(:results)).to eq([raid])
    end

    it_behaves_like "require_sign_in" do  
      let(:action) { get :search, search_term: 'raid' }
    end
  end
end
