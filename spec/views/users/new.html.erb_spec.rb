require 'rails_helper'

RSpec.describe 'users/new.html.erb', type: :system do
  context 'while creating user account' do
    it 'creates account successfully when info is valid' do
      visit signup_path
      within('.sign-inup-form') do
        fill_in 'user_name', with: 'testie'
      end
      click_button 'Signup'
      expect(page).to have_content('Successfully created your account!')
    end

    it 'creates exception when username is invalid' do
      visit signup_path
      click_button 'Signup'
      expect(page).to have_content('Failed to create account. Try again!')
    end

    it 'creates exception when user already exists' do
      u = User.create(name: 'ironmania')
      visit signup_path
      within('.sign-inup-form') do
        fill_in 'user_name', with: u.name
      end
      click_button 'Signup'
      expect(page).to have_content('Failed to create account. Try again!')
    end
  end
end
