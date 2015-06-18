require 'spec_helper'

describe QueueItemsController do
  context "for authenticated users" do 
    let(:current_user) { Fabricate(:user) }
    before { session[:user_id] = current_user.id }

    describe 'GET index' do
      it "should render the :index template" do
        get :index
        expect(response).to render_template(:index)
      end

      it "sets @queue_items" do  
        video = Fabricate(:video)
        queue_item = Fabricate(:queue_item)
        queue_item.video_id = video.id
        current_user.queue_items << queue_item 
        get :index
        expect(assigns(:queue_items)).to include(queue_item) 
      end
    end

    describe 'PATCH update' do
      it "creates a queue item" do
        queue_item = Fabricate(:queue_item)
        expect(QueueItem.count).to eq(1)
      end

      it "creates a queue item associated with video" do
        video = Fabricate(:video)
        queue_item = Fabricate(:queue_item)
        queue_item.video_id = video.id
        expect(queue_item.video_id).to eq(video.id)
      end

      it "creates a queue item associated with current user" do
        video = Fabricate(:video)
        queue_item = Fabricate(:queue_item)
        queue_item.video_id = video.id
        current_user.queue_items << queue_item 
        expect(queue_item.user_id).to eq(current_user.id)
      end

      it "creates a queue item at end of the list" do
        video = Fabricate(:video)
        queue_item = Fabricate(:queue_item)
        queue_item.video_id = video.id
        current_user.queue_items << queue_item 
        expect(QueueItem.last).to eq(queue_item)
      end

      it "sets the notice" do
        video = Fabricate(:video)
        patch :update, id: video.id
        expect(flash[:notice]).not_to be_blank 
      end

      it "redirects back to video show page" do
        video = Fabricate(:video)
        patch :update, id: video.id
        expect(response).to redirect_to(video_path(video))
      end
    end
  end
end