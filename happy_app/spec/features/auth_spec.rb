require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do
  it "expect page to have sign up button" do 
    visit users_path
    expect(page).to have_content('Sign Up!')
  end
  
  scenario 'has a new user page' do
    visit new_user_path
    expect(page).to have_content('Username')
    expect(page).to have_content('Password')
  end
    
  feature 'signing up a user' do

    scenario 'shows username on the homepage after signup' do
      visit new_user_path 
      fill_in 'Username', with: "Dorkyface"
      fill_in 'Password', with: "123456"
      click_button 'Submit!!!'
      expect(page).to have_content('Dorkyface')
      user = User.find_by(username: 'Dorkyface')
      expect(current_path).to eq(user_path(user))
    end
  end
  feature 'failure to sign up user' do

    scenario 'Redirects to new user signup page' do
      visit new_user_path 
      fill_in 'Username', with: "Dorkyface"
      fill_in 'Password', with: "16"
      click_button 'Submit!!!'
      expect(current_path).to eq(new_user_path)
    end
      

  end
end

feature 'logging in' do
  scenario 'shows username on the homepage after login' do
    User.create(username: 'robie', password: 'therobot')
    visit users_path
    click_link 'Log in!'
    fill_in 'Username', with: 'robie'
    fill_in 'Password', with: 'therobot'
    click_button 'Submit!!!'
    user = User.find_by(username: 'robie')
    expect(current_path).to eq(user_path(user))
  end
      
end

feature 'logging out' do
  before :each do
    User.create(username: 'robie', password: 'therobot')
    visit users_path
    click_link 'Log in!'
    fill_in 'Username', with: 'robie'
    fill_in 'Password', with: 'therobot'
    click_button 'Submit!!!'
    click_button 'Log Out!'
  end
  
  scenario 'begins with a logged out state' do
    expect(current_path).to eq(new_session_path)
  end

  scenario 'doesn\'t show username on the homepage after logout' do
    expect(page).not_to have_content('robie')
  end

end