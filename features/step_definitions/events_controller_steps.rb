# features/step_definitions/events_controller_steps.rb

Given('there are some events in the system') do
  # You may need to create some events in your database
  # For example, using FactoryBot or a similar library
  @event1 = Event.create(
    name: "Sample Event 1",
    description: "This is a sample event description.",
    county_id: 1,
    start_time: DateTime.now,
    end_time: DateTime.now + 1.hour
  )
  @event2 = Event.create(
    name: "Sample Event 2",
    description: "This is a sample event description.",
    county_id: 2,
    start_time: DateTime.now,
    end_time: DateTime.now + 1.hour
  )
end

When('I visit the events page') do
  visit events_path
end

Then('I should see a list of events') do
  expect(page).to have_content(@event1.name)
  expect(page).to have_content(@event2.name)
  # Add more expectations based on the actual content of the events page
end

Given('there is an event in the system') do
  @event = Event.create(
    name: "Sample Event",
    description: "This is a sample event description.",
    county_id: 2,
    start_time: DateTime.now,
    end_time: DateTime.now + 1.hour
  )
end

When('I visit the event page') do
  visit event_path(@event)
end

Then('I should see details of the event') do
  expect(page).to have_content(@event.name)
  expect(page).to have_content(@event.description)
  # Add more expectations based on the actual content of the event page
end

When('I filter events by state') do
  # You may need to set up test data for states and events in specific states
  @state = create(:state, name: 'California', symbol: 'CA')
  @event_in_state = create(:event, county: create(:county, state: @state))
  visit events_path('filter-by' => 'state', 'state' => 'CA')
end

Then('I should see a list of events in that state') do
  expect(page).to have_content(@event_in_state.name)
  # Add more expectations based on the actual content of the events page
end

When('I filter events by county') do
  # You may need to set up test data for counties and events in specific counties
  @county = create(:county, state: create(:state, name: 'California', symbol: 'CA'))
  @event_in_county = create(:event, county: @county)
  visit events_path('filter-by' => 'county', 'state' => 'CA', 'county' => @county.fips_code)
end

Then('I should see a list of events in that county') do
  expect(page).to have_content(@event_in_county.name)
  # Add more expectations based on the actual content of the events page
end

When('I filter events by state only') do
  # You may need to set up test data for events in specific states
  @state = create(:state, name: 'California', symbol: 'CA')
  @event_in_state = create(:event, county: create(:county, state: @state))
  @event_in_other_state = create(:event, county: create(:county))
  visit events_path('filter-by' => 'state-only', 'state' => 'CA')
end

Then('I should see a list of events in that state') do
  expect(page).to have_content(@event_in_state.name)
  # Add more expectations based on the actual content of the events page

  # Ensure events from other states are not visible
  expect(page).not_to have_content(@event_in_other_state.name)
end
