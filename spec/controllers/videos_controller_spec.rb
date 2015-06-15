require 'spec_helper'

describe VideosController do
  let(:video) { Fabricate(:video) }

  describe "GET show" do
    it "assigns @video with authenticated users" do
      session[:user_id] = Fabricate(:user).id
      get :show, id: video.id
      expect(assigns(:video)).to eq(video)
    end

    it "sets @reviews for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      review1 = Fabricate(:review, video: video)
      review2 = Fabricate(:review, video: video)
      get :show, id: video.id
      expect(assigns(:reviews)).to match_array([review1, review2])
    end

    it "redirects the unauthorized users to the sign in page" do
      get :show, id: video.id
      expect(response).to redirect_to(sign_in_path)
    end
  end

  describe "GET search" do
    it "assigns @results with authenticated users" do
      session[:user_id] = Fabricate(:user).id
      raid = Fabricate(:video, title: "Raid", description: "An action movie!")
      get :search, search_term: 'raid'
      expect(assigns(:results)).to eq([raid])
    end

    it "redirects to sign in page for unauthenticated users" do
      get :search, search_term: 'raid'
      expect(response).to redirect_to(sign_in_path)
    end
  end
end
