require 'rails_helper'
require 'capybara/rspec'
RSpec.describe 'events managments', type: :feature do
  scenario 'events have all events index' do
    visit root_path
    sleep(2)
    expect(page).to have_content('All Events')
  end
  scenario 'events have Past events index' do
    visit events_path
    sleep(2)
    expect(page).to have_content('Previous Events')
  end
  scenario 'events have Future events index' do
    visit events_path
    sleep(2)
    expect(page).to have_content('Upcoming Events')
  end
  scenario 'Not logged user should not see create new event form' do
    visit events_path
    click_link "Create Event"
    expect(page).to have_content('Login')
  end
end