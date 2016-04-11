require 'rails_helper'

feature 'User Accounts' do
  scenario "mindvalley staff can login" do
    sign_out
    subject {create(:staff)}

    visit root_page
    click_link 'Login'

    expect(page).to have_content subject.email
  end
end