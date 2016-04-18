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
    user = create_user

    visit root_path
 
    click_link 'Login'

    expect(page).to have_content user.first_name
  end

  #user can view user profiles
  scenario 'mindvalley staff can view profiles' do
    user = create(:staff)
    colleague = create(:staff)

    login_as(user, :scope => :user)

    visit user_goals_path(colleague)

    expect(page).to have_content colleague.first_name
  end
end