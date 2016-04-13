require 'rails_helper'

feature 'User Accounts' do
  scenario "users can see login" do
    visit root_path

    expect(page).to have_link 'Login', user_omniauth_authorize_path(:mindvalley)
  end

  #user can login
  scenario 'login works' do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:mindvalley] = build(:staff_hash)
    
    visit root_path
    # byebug
    # @request.env["devise.mapping"] = Devise.mappings[:user]


    click_link 'Login'


    it 'redirects to home page' do
      expect(response).to redirect_to root_path
    end

    it 'signs in the user' do
      expect(page).to have_content response_hash['info']['email']
    end


  end
end