require 'rails_helper'

feature 'User Accounts' do
  scenario "mindvalley staff can login" do
    visit root_path

    expect(page).to have_link 'Login'
  end
end