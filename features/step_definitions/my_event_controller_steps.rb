# features/step_definitions/my_events_controller_steps.rb

Given(/^I am on the new event page$/) do
  visit new_my_event_path
end

When(/^I fill in the form with valid event data$/) do
  fill_in 'event_name', with: 'New Event'
  fill_in 'event_county_id', with: '1'
  fill_in 'event_description', with: 'Test Description'
  fill_in 'event_start_time', with: '2023-01-01 10:00'
  fill_in 'event_end_time', with: '2023-01-01 12:00'
end

When(/^I press the "Create Event" button$/) do
  click_button 'Create Event'
end

Then(/^I should be redirected to the events page$/) do
  expect(page).to have_current_path(events_path)
end

Then(/^I should see a notice "(.*?)"$/) do |notice|
  expect(page).to have_content(notice)
end

Then(/^I should see the new event in the list of events$/) do
  expect(page).to have_content('New Event')
end

When(/^I fill in the form with invalid event data$/) do
  fill_in 'event_name', with: '' # Provide invalid data that will fail validation
end

Then(/^I should see an error message$/) do
  expect(page).to have_content('Error') # Adjust based on your application's error messages
end

Then(/^I should stay on the new event page$/) do
  expect(page).to have_current_path(new_my_event_path)
end

Given(/^there is an existing event with name "(.*?)"$/) do |event_name|
  Event.create(name: event_name, county_id: '1', description: 'Existing Event', start_time: '2023-01-01 10:00', end_time: '2023-01-01 12:00')
end

When(/^I visit the edit page for "(.*?)"$/) do |event_name|
  event = Event.find_by(name: event_name)
  visit edit_my_event_path(event)
end

When(/^I change the event's description to "(.*?)"$/) do |new_description|
  fill_in 'event_description', with: new_description
end

When(/^I press the "Update Event" button$/) do
  click_button 'Update Event'
end

Then(/^I should see "(.*?)" in the list of events$/) do |description|
  expect(page).to have_content(description)
end

When(/^I press the "Delete Event" button$/) do
  click_link 'Delete Event' # Adjust based on your application's delete button/link
end

Then(/^I should not see "(.*?)" in the list of events$/) do |event_name|
  expect(page).not_to have_content(event_name)
end