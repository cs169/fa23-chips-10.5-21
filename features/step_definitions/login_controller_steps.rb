# features/step_definitions/login_controller_steps.rb

Given('I am on the login page') do
  visit login_path
end

Then('I should see the login form') do
  expect(page).to have_current_path('/login')
end

When('I click the {string} button') do |button_text|
  click_button "
  Sign in with GitHub"
end

Then('I should be redirected to the map') do
  expect(page).to have_current_path('')
end

Given('I am logged in') do
  visit login_path 
  click_button "
  Sign in with GitHub"
end

Then('I should be logged out') do
  expect(page).to have_current_path('/logout')
end

Then('I should be redirected to the home page') do
  expect(page).to have_current_path(root_path)
end

Then('I should see a logout notice') do
  expect(page).to have_content('You have successfully logged out.')
end
