require 'rails_helper'
require 'capybara/rspec'
RSpec.feature 'Forms', type: :feature do

  scenario 'Authentication, User can login with registered name' do
    user = User.create(username:'Freezer',
                  email: 'email@example.com',
                  password: 'anything')
    visit login_path
    fill_in :username, with: "Freezer"
    click_button 'Login'
    expect(page).to have_content('Logged in!')
  end
end