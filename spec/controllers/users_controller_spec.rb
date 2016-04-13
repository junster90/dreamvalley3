require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe '#show' do
    describe 'GET' do
      subject { create(:user) }

      it "assigns the right user" do
        get :show
        expect(assigns(:user)).to eq subject
      end

      it 'renders the :new template' do
        get :show
        expect(response).to render_template 'show'
      end
    end
  end
end
