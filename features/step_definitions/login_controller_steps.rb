# features/step_definitions/login_controller_steps.rb

Given('I am on the login page') do
  visit login_path
end

Then('I should see the login form') do
  expect(page).to have_selector('form#login-form')
end

When('I click the {string} button') do |button_text|
  click_button button_text
end

Then('I should be redirected to the Google login page') do
  # You may need to adjust this step based on your actual implementation
  expect(page).to have_current_path('/users/auth/google_oauth2')
end

Given('I am logged in') do
  # Assuming you have a method to log in a user for testing purposes
  # This can be a helper method or a step definition
  # For example, if you're using Devise for authentication:
  @user = create(:user) # You may need to adjust this based on your user creation method
  login_as(@user, scope: :user)
end

Then('I should be logged out') do
  expect(page).to have_content('You have successfully logged out.')
end

Then('I should be redirected to the home page') do
  expect(page).to have_current_path(root_path)
end

Then('I should see a logout notice') do
  expect(page).to have_content('You have successfully logged out.')
end
