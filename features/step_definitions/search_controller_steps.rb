# frozen_string_literal: true

Given('I am on the representatives page') do
  visit representatives_path
end

When('I enter the address {string}') do |address|
  fill_in 'address', with: address
end

When('I click the search button') do
  click_button 'Search'
end

Then('I should be on the representatives page') do
  expect(current_path).to eq('/search')
end

Then('I should be on the search page') do
  expect(current_path).to eq('/representatives')
end

Then('I should see a list of representatives from California') do
  expect(page).to have_selector('.representative', count: 19)
end

Then('I should see name {string}') do |name|
  expect(page).to have_content(name)
  # Assuming each representative is displayed with a CSS class '.representative'
end

When('I enter an invalid address') do
  # You can simulate entering an invalid address here.
  # For example, you can fill in the address field with a known invalid value.
  fill_in 'address', with: 'invalid_address'
end
