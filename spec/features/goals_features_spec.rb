require 'rails_helper'

feature 'Goals Features' do
  scenario 'user can create goals' do
    create_and_login_user

    visit new_goal_path

    expect(page).to have_content "New Goal"
  end

  scenario 'user can view goals' do

  end

end