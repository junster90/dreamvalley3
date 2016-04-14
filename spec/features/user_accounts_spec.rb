require 'rails_helper'

feature 'User Accounts' do
  scenario "users can see login" do
    visit root_path

    expect(page).to have_link 'Login', user_omniauth_authorize_path(:mindvalley)
  end

  #user can login
  scenario 'mindvalley staff can login' do
    # Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
    # Rails.application.env_config["omniauth.auth"] = build(:staff_hash)
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:mindvalley] = build(:staff_hash)
    user = User.create!(
      password: "password",
      password_confirmation: "password",
      provider: OmniAuth.config.mock_auth[:mindvalley]["provider"],
      uid: OmniAuth.config.mock_auth[:mindvalley]["uid"],
      first_name: OmniAuth.config.mock_auth[:mindvalley]["info"]["first_name"],
      last_name: OmniAuth.config.mock_auth[:mindvalley]['info']['last_name'],
      email: OmniAuth.config.mock_auth[:mindvalley]["info"]["email"],
      token: OmniAuth.config.mock_auth[:mindvalley]["credentials"]["token"],
      id_token: OmniAuth.config.mock_auth[:mindvalley]["credentials"]["id_token"]
    )

    visit root_path
 
    click_link 'Login'

    expect(page).to have_content OmniAuth.config.mock_auth[:mindvalley]['info']['first_name']
  end

  #user can view user profiles
  scenario 'mindvalley staff can view profiles' do
    user = create(:staff)
    colleague = create(:staff)

    login_as(user, :scope => :user)

    visit user_path(colleague)

    expect(page).to have_content colleague.first_name
  end

  scenario 'user gets redirected to sign in before user can view profiles' do
    user = create(:staff)
    colleague = create(:staff)

    visit user_path(colleague)

    expect(current_path).to eq user_omniauth_authorize_path(:mindvalley)
  end

end