require 'spec_helper'

describe RelationshipsController do 
  let(:user) { Fabricate(:user) }
  let(:follower) { Fabricate(:user) }

  describe "GET index" do 
    it_behaves_like "require_sign_in" do 
      let(:action) { get :index, id: 3 }
    end

    it "sets the @followings variable" do 
      set_current_user
      Relationship.create(following_id: user.id, user_id: current_user.id)
      get :index, id: current_user.id
      expect(assigns(:followings)).to eq(current_user.followings)
    end
  end

  describe "POST create" do 
    before do 
      set_current_user
      set_referrer
    end

    it_behaves_like "require_sign_in" do 
      let(:action) { post :create, following_id: 3 }
    end

    it "creates the follow relationship" do 
      post :create, following_id: user.id
      expect(Relationship.count).to eq(1)
    end

    it "should not be able to follow yourself" do 
      post :create, following_id: current_user.id, user_id: current_user.id
      expect(Relationship.count).to eq(0)
    end

    it "should not be able to follow a person you're already following" do 
      Relationship.create!(following_id: user.id, user_id: current_user.id)
      post :create, following_id: user.id
      expect(Relationship.count).not_to eq(2)
    end

    it "redirects to people show page for current user" do 
      post :create, following_id: user.id
      expect(response).to redirect_to relationships_path(current_user)
    end
  end

  describe "DELETE destroy" do 
    before do 
      set_current_user
      Relationship.create(following_id: user.id, user_id: current_user.id)
      delete :destroy, id: user.id
    end

    it_behaves_like "require_sign_in" do 
      let(:action) { delete :destroy, id: 3 }
    end

    it "creates destroy the relationship" do 
      expect(Relationship.count).to eq(0)
    end

    it "redirects to people show page for current user" do 
      expect(response).to redirect_to relationships_path(current_user)
    end
  end
end