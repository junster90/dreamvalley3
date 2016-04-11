require 'rails_helper'

feature 'Homepage' do
  scenario 'user sees the homepage' do
    visit root_path

    expect(page).to have_content "Dreamvalley"
  end
end