require 'rails_helper'

RSpec.describe GoalsController, type: :controller do
  describe '#new' do
    it 'requires a user to be logged in' do
      get :new

      expect(response).to redirect_to user_omniauth_authorize_path(:mindvalley)
    end

    it 'renders the :new template' do
      user = create_user
      sign_in user

      get :new

      expect(response).to render_template 'new'
    end
  end
end
