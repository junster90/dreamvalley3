require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe '#show' do
    describe 'GET' do
      subject { create(:staff) }

      it 'redirects non-signed in users to sign in' do
        get :show, id: subject.id
        
        expect(response).to redirect_to user_omniauth_authorize_path(:mindvalley)
      end

      it "assigns the right user" do
        sign_in subject
        get :show, id: subject.id
        expect(assigns(:user)).to eq subject
      end

      it 'renders the :show template' do
        sign_in subject
        get :show, id: subject.id
        expect(response).to render_template 'show'
      end
    end
  end
end
