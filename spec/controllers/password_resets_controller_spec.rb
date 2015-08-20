require 'spec_helper'

describe PasswordResetsController do 
  describe "GET show" do 
    it "renders show template if the token is valid" do 
      aaron = Fabricate(:user)
      aaron.update_column(:token, '12345')
      get :show, id: '12345'
      expect(response).to render_template :show
    end

    it "sets @token" do 
      aaron = Fabricate(:user)
      aaron.update_column(:token, '12345')
      get :show, id: '12345'
      expect(assigns(:token)).to eq('12345')
    end

    it "redirects to the expired token page if the token is not valid" do
      get :show, id: '12345'
      expect(response).to redirect_to expired_token_path
    end
  end

  describe "POST create" do 
    context "with valid token" do 
      it "should redirect to sign in page" do 
        aaron = Fabricate(:user, password: 'old_password')
        aaron.update_column(:token, '12345')
        post :create, token: '12345', password: 'new_password'
        expect(response).to redirect_to sign_in_path
      end

      it "should update the user's password" do 
        aaron = Fabricate(:user, password: 'old_password')
        aaron.update_column(:token, '12345')
        post :create, token: '12345', password: 'new_password'
        expect(aaron.reload.authenticate('new_password')).to be_truthy
      end

      it "should flash success message" do 
        aaron = Fabricate(:user, password: 'old_password')
        aaron.update_column(:token, '12345')
        post :create, token: '12345', password: 'new_password'
        expect(flash[:success]).to be_present
      end

      it "should regenerate the user's token" do 
        aaron = Fabricate(:user, password: 'old_password')
        aaron.update_column(:token, '12345')
        post :create, token: '12345', password: 'new_password'
        expect(aaron.reload.token).not_to eq('12345')
      end
    end

    context "with invalid token" do 
      it "redirects to expired token path" do
        post :create, token: '12345', password: 'some_password'
        expect(response).to redirect_to expired_token_path
      end
    end
  end
end