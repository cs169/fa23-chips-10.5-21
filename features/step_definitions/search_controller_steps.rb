# features/step_definitions/representatives_steps.rb

Given('I am on the representatives page') do
  visit representatives_path
end

When('I enter the address {string}') do |address|
  fill_in 'address', with: address
end

When('I click the search button') do
  click_button 'Search'
end

Then('I should be on the search page') do
  expect(current_path).to eq('/search')
end

Then('I should see a list of representatives from California') do
  expect(page).to have_selector('.representative', count: 19)
end

Then('I should see name {string}') do |name|
  expect(page).to have_content(name)
end

When('I enter an invalid address') do
  fill_in 'address', with: 'invalid_address'
end
