require 'spec_helper'

describe InvitationsController do  
  describe "GET new" do 
    it "sets @invitation to a new invitation" do 
      set_current_user
      get :new
      expect(assigns(:invitation)).to be_new_record
      expect(assigns(:invitation)).to be_instance_of Invitation
    end

    it_behaves_like "require_sign_in" do 
      let(:action) { get :new }
    end
  end

  describe "POST create" do 
    it_behaves_like "require_sign_in" do 
      let(:action) { post :create }
    end

    context "with valid input" do 
      it "redirects to the invitation new page" do 
        set_current_user
        post :create, invitation: { recipient_name: "Aaron Temple", recipient_email: "aaron@example.com", message: "Please join MyFlix!" }
        expect(response).to redirect_to invite_path
      end

      # it "creates an invitation" do 
      #   set_current_user
      #   post :create, invitation: { recipient_name: "Aaron Temple", recipient_email: "aaron@example.com", message: "Please join MyFlix!" }
      #   expect(Invitation.count).to eq(1)
      # end

      it "sends email to recipient"
      it "sets the flash success message"
    end
    context "with invalid input"
  end
end