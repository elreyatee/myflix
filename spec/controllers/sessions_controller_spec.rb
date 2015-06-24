require 'spec_helper'

describe SessionsController do
  describe "GET new" do
    it "redirects to home page for authenticated users" do
      set_current_user
      get :new
      expect(response).to redirect_to home_path
    end

    it "render new template for unauthenticated users" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST create" do
    let(:ellery) { Fabricate(:user) }

    context "with valid credentials" do
      before do
        post :create, email: ellery.email, password: ellery.password
      end

      it "puts the signed in user in the session" do
        expect(session[:user_id]).to eq(ellery.id)
      end

      it "redirects user to the home page" do
        expect(response).to redirect_to home_path
      end

      it "sets the notice" do
        expect(flash[:notice]).not_to be_blank
      end
    end

    context "with invalid credentials" do
      before do
        post :create, email: ellery.email, password: "wrong"
      end

      it "does not put user in the session" do
        expect(session[:user_id]).to be_nil
      end

      it "redirects user to the sign in page" do
        expect(response).to render_template :new
      end

      it "sets the error message" do
        expect(flash[:error]).not_to be_blank
      end
    end
  end

  describe "GET destroy" do
    before do
      clear_current_user
      get :destroy
    end

    it "clears the session for the user" do
      expect(session[:user_id]).to be_nil
    end

    it "redirects user to front page" do
      expect(response).to redirect_to(root_path)
    end

    it "sets the notice" do
      expect(flash[:notice]).not_to be_blank
    end
  end
end
