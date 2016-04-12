require 'rails_helper'

feature 'User Accounts' do
  scenario "mindvalley staff can login" do
    visit root_path
    click_link 'Login'

    expect(page).to have_content subject.email
  end
end