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
    end
  end
end