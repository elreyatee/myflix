require 'spec_helper'

describe QueueItemsController do
  let(:current_user) { Fabricate(:user) }
  before { session[:user_id] = current_user.id }

  describe "GET index" do
    it "should render the :index template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "sets @queue_items of logged in user" do  
      queue_item1 = Fabricate(:queue_item, user: current_user)
      queue_item2 = Fabricate(:queue_item, user: current_user)
      get :index
      expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2]) 
    end

    it "redirects to sign in page for unauthenticated users" do
      session[:user_id] = nil
      get :index
      expect(response).to redirect_to(sign_in_path)
    end
  end

  describe "POST create" do
    it "creates a queue item" do
      video = Fabricate(:video)
      post :create, id: video.id
      expect(QueueItem.count).to eq(1)
    end

    it "creates a queue item associated with video" do
      video = Fabricate(:video)
      post :create, id: video.id
      expect(QueueItem.first.video).to eq(video)
    end

    it "creates a queue item associated with current user" do
      video = Fabricate(:video)
      post :create, id: video.id
      expect(QueueItem.first.user).to eq(current_user)
    end

    it "creates a queue item at end of the list" do
      raid = Fabricate(:video, title: "Raid")
      matrix = Fabricate(:video, title: "The Matrix")
      Fabricate(:queue_item, user: current_user, video: matrix)
      raid_queue_item = Fabricate(:queue_item, user: current_user, video: raid)
      post :create, id: raid.id
      expect(QueueItem.last).to eq(raid_queue_item)
    end

    it "redirects back to my_queue page" do
      video = Fabricate(:video)
      post :create, id: video.id
      expect(response).to redirect_to(my_queue_path)
    end

    it "does not add video to the queue if it's already in the queue" do
      raid = Fabricate(:video, title: "Raid")
      Fabricate(:queue_item, user: current_user, video: raid)
      post :create, id: raid.id
      expect(current_user.queue_items.count).to eq(1)
    end

    it "redirects to sign in page for unauthenticated users" do
      session[:user_id] = nil
      video = Fabricate(:video)
      post :create, id: video.id
      expect(response).to redirect_to(sign_in_path)
    end
  end

  describe "DELETE destroy" do
    it "redirects to my_queue page" do
      queue_item = Fabricate(:queue_item)
      delete :destroy, id: queue_item.id
      expect(response).to redirect_to(my_queue_path)
    end

    it "deletes the queue item" do
      queue_item = Fabricate(:queue_item, user: current_user)
      delete :destroy, id: queue_item.id
      expect(current_user.queue_items.count).to eq(0)
    end

    it "does not delete the queue item if the queue item is not in current user's queue" do
      bob = Fabricate(:user)
      queue_item = Fabricate(:queue_item, user: bob)
      delete :destroy, id: queue_item.id
      expect(QueueItem.count).to eq(1)
    end

    it "redirects to sign in page for unauthenticated users" do 
      session[:user_id] = nil
      delete :destroy, id: 5
      expect(response).to redirect_to(sign_in_path)
    end

    # it "reorders all queue items list postitions" do
    #   queue_item1 = Fabricate(:queue_item, list_position: 1)
    #   queue_item2 = Fabricate(:queue_item, list_position: 2)
    #   delete :destroy, id: queue_item1.id
    #   expect(queue_item2.list_position).to eq(1)
    # end
  end
end