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
  expect(current_path).to eq(search_representatives_path)
end

Then('I should see a list of representatives from California') do
  expect(page).to have_selector('.representative', count: 19)
  # Assuming each representative is displayed with a CSS class '.representative'
end

Then('I should see name {string}') do |name|
  expect(page).to have_content(name)
  # Assuming each representative is displayed with a CSS class '.representative'
end

Then('I should see an error message') do
  expect(page).to have_content('Invalid address. Please enter a valid address.')
  # Modify this expectation based on the actual error message displayed on the page
end