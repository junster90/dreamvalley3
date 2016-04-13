require 'rails_helper'

feature 'User Accounts' do
  scenario "users can see login" do
    visit root_path

    expect(page).to have_link 'Login', user_omniauth_authorize_path(:mindvalley)
  end

  #user can login
  scenario 'mindvalley staff can login' do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:mindvalley] = build(:staff_hash)

    visit root_path
 
    click_link 'Login'

    expect(page).to have_content OmniAuth.config.mock_auth[:mindvalley]['info']['email']
  end
end