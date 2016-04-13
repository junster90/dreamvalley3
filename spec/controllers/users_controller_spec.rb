require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe '#show' do
    describe 'GET' do
      subject { create(:staff) }

      it "assigns the right user" do
        get :show, id: subject.id
        expect(assigns(:user)).to eq subject
      end

      it 'renders the :show template' do
        get :show, id: subject.id
        expect(response).to render_template 'show'
      end
    end
  end
end
