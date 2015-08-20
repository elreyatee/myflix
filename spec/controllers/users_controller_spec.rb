require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "sets the @user variable" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "POST create" do
    context "with valid input" do
      before { post :create, user: Fabricate.attributes_for(:user) }

      it "creates the user" do
        expect(User.count).to eq(1)
      end

      it "redirects to sign in page" do
        expect(response).to redirect_to sign_in_path
      end
    end

    context "with invalid input" do
      before { post :create, user: { password: "password", name: "David" } }

      it "does not create the user" do
        expect(User.count).to eq(0)
      end

      it "render the new template" do
        expect(response).to render_template :new
      end

      it "sets @user" do
        expect(assigns(:user)).to be_instance_of User
      end
    end

    context "sending email" do 
      after { ActionMailer::Base.deliveries.clear }

      it "sends out email to user with valid inputs" do 
        post :create, user: { name: "Aaron", email: "aaron@example.com", password: "12345678" }
        expect(ActionMailer::Base.deliveries.last.to).to eq(["aaron@example.com"])
      end

      it "send out email containing user's name with valid inputs" do 
        post :create, user: { name: "Aaron", email: "aaron@example.com", password: "12345678" }
        expect(ActionMailer::Base.deliveries.last.body).to include("Aaron")
      end

      it "does not send out email with invalid inputs" do 
        post :create, user: { name: "Aaron", email: "aaron@example.com" }
        expect(ActionMailer::Base.deliveries).to be_empty
      end
    end
  end

  describe "GET show" do 
    it_behaves_like "require_sign_in" do 
      let(:action) { get :show, id: 3 }
    end

    it "sets @user" do 
      set_current_user
      bob = Fabricate(:user)
      get :show, id: bob.id
      expect(assigns(:user)).to eq(bob)
    end
  end

  describe "PATCH update" do 

  end 
end
