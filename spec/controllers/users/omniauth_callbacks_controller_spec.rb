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

      xit 'redirects to the user profile page' do

      end
    end

    context 'a non-mindvalley staff logs in' do

    end
    # fake a response hash
    # stub the user class methods to check user persisting
    # check if sign in with devise works by expecting page to have "signed in"
  end

  describe '#failure' do

  end
end
