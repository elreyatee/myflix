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
  end
end