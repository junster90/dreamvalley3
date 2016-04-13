require 'rails_helper'

RSpec.describe Users::OmniauthCallbacksController, type: :controller do
  describe '#callback' do
    context 'a mindvalley staff returns from auth0' do
      let(:response_hash) { build(:staff_hash) }
      let(:staff) {
        User.new(
          provider: response_hash["provider"],
          uid: response_hash["uid"],
          first_name: response_hash["info"]["first_name"],
          last_name: response_hash['info']['last_name'],
          email: response_hash["info"]["email"],
          token: response_hash["credentials"]["token"],
          id_token: response_hash["credentials"]["id_token"]
        )
      }

      before do 
        @request.env["devise.mapping"] = Devise.mappings[:user]
        allow(User).to receive(:from_omniauth).and_return(staff)
        get :mindvalley
      end

      it 'assigns the correct user' do
        expect(assigns(:user)).to eq staff
      end

      it 'signs in the user to session' do
        expect(controller.current_user).to eq staff
      end

      it 'saves the user' do
        user = User.find_by(email: response_hash["info"]["email"])

        expect(user.email).to eq response_hash["info"]["email"]
      end

      xit 'redirects to the user profile page' do

      end
    end

    context 'when a non-mindvalley staff returns from auth0' do
      let(:response_hash) { build(:nonstaff_hash) }
      let(:nonstaff) {
        User.new(
          provider: response_hash["provider"],
          uid: response_hash["uid"],
          first_name: response_hash["info"]["first_name"],
          last_name: response_hash['info']['last_name'],
          email: response_hash["info"]["email"],
          token: response_hash["credentials"]["token"],
          id_token: response_hash["credentials"]["id_token"]
        )
      }

      before do 
        @request.env["devise.mapping"] = Devise.mappings[:user]
        allow(User).to receive(:from_omniauth).and_return(nonstaff)
        get :mindvalley
      end

      it 'assigns the correct user' do
        expect(assigns(:user)).to eq nonstaff
      end

      it 'does not sign in the user to session' do
        expect(controller.current_user).to be_nil
      end

      it 'does not saves the user' do
        user = User.find_by(email: response_hash["info"]["email"])
        
        expect(user).to eq nil
      end

      it 'redirects to the root page with an error' do
        expect(flash[:error]).to eq "Sorry, you're not authorised."
        expect(response).to redirect_to(root_path)
      end

    end
  end

  describe '#failure' do

  end
end
