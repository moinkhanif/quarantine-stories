require 'rails_helper'

RSpec.describe 'sessions/new.html.erb', type: :system do
  context 'while logging into a user account' do
    it 'successfully logs in when a correct name is provided' do
      u = User.create(name: 'testie')
      visit login_path
      within('.sign-inup-form') do
        fill_in 'user_name', with: u.name
      end
      click_button 'Login'
      expect(page).to have_content("Successfully logged in as #{u.name.capitalize}")
    end

    it 'creates exception when username does not exist' do
      visit login_path
      click_button 'Login'
      expect(page).to have_content('Name does not exist! Please try again or sign up')
    end
  end
end
