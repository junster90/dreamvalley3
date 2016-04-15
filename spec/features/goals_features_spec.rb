require 'rails_helper'

feature 'Goals Features' do
  scenario 'user can create goals' do
    user = create_and_login_user

    visit new_user_goal_path(user)

    expect(page).to have_content "New Goal"
  end

  scenario 'user can view goals' do

  end

end