require 'rails_helper'

feature 'User Accounts' do
  scenario "users can see login" do
    visit root_path

    expect(page).to have_link 'Login', user_omniauth_authorize_path(:mindvalley)
  end
end