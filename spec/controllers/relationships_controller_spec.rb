require 'spec_helper'

describe RelationshipsController do 
  let(:user) { Fabricate(:user) }
  let(:follower) { Fabricate(:user) }

  describe "GET show" do 
    it_behaves_like "require_sign_in" do 
      let(:action) { get :show, id: 3 }
    end

    it "sets the @followings variable" do 
      set_current_user
      Relationship.create(following_id: user.id, user_id: current_user.id)
      get :show, id: current_user.id
      expect(assigns(:followings)).to eq(current_user.followings)
    end
  end

  describe "POST create" do 
    it_behaves_like "require_sign_in" do 
      let(:action) { post :create, following_id: 3 }
    end

    it "creates the follow relationship" do 
      set_current_user
      post :create, following_id: user.id
      expect(Relationship.count).to eq(1)
    end
  end

  describe "DELETE destroy" do 
    it_behaves_like "require_sign_in" do 
      let(:action) { delete :destroy, id: 3 }
    end

    it "creates destroy the relationship" do 
      set_current_user
      Relationship.create(following_id: user.id, user_id: current_user.id)
      delete :destroy, id: user.id
      expect(Relationship.count).to eq(0)
    end
  end
end