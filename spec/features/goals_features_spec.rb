require 'rails_helper'

feature 'Goals Features' do
  scenario 'user can create goals' do
    user = create_and_login_user
    visit new_user_goal_path(user)

    expect(page).to have_content "New Goal"
  end

  scenario 'user tries to submit goal form' do
    user = create_and_login_user
    visit new_user_goal_path(user)

    fill_in "Description", with: "I want a pet penguin!"
    select random_question, from: "goals[category]"

    click_button "Submit"

    expect(page).to have_content "I want a pet penguin!"
  end

  scenario 'creates goal of each type' do
    user = create_and_login_user
    GoalsHelper::Questions.each do |cat|
      create_goal(cat.first, user)
      expect(page).to have_content cat.last
    end 
  end

  scenario 'user can view users goals' do
    user = create_and_login_user
    create_goal(random_question, user)

    visit user_goals_path(user)

    expect(page).to have_content "I want a pet penguin!"
  end

  scenario 'user can edit goals' do
    user = create_and_login_user
    create_goal(random_question, user)

    visit edit_user_goal_path(user, user.goals.last)

    fill_in "Description", with: "EDITED!"
    select random_question, from: "goals[category]"
    click_button 'Submit'

    expect(page).to have_content "EDITED!"
  end

  def random_question
    GoalsHelper::Questions.sample.first
  end

  def create_goal(cat, user)
    visit new_user_goal_path(user)
    fill_in "Description", with: "I want a pet penguin!"
    select cat, from: "goals[category]"
    click_button "Submit"
  end     
end