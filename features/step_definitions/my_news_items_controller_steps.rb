# features/step_definitions/my_news_items_controller_steps.rb

def mock_authenticated_user
  user = User.create!(email: 'user@example.com', password: 'password')
  allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
end



Given('there is a representative in the system') do
  @representative = Representative.create(
    name: "John Doe",
    created_at: DateTime.now,
    updated_at: DateTime.now,
    ocdid: "ocdid123",
    title: "Senator",
    address_street: "123 Main St",
    address_city: "Cityville",
    address_state: "CA",
    address_zip: "12345",
    party: "Democratic",
    photo_url: "https://example.com/johndoe.jpg"
  )
end

Given('there is an existing news item') do
  @news_item = NewsItem.create(
    title: "Breaking News",
    link: "https://example.com/breaking-news",
    description: "This is a breaking news story.",
    representative_id: representative.id,
    created_at: DateTime.now,
    updated_at: DateTime.now
  )
end

When('I visit the new news item page') do
  visit representative_new_my_news_item_path(@representative)
end

When('I fill in the news item form') do
  puts page.body
  fill_in 'news_item_title', with: 'New News Item'
  fill_in 'news_item_description', with: 'Description for the new news item.'
  fill_in 'news_item_link', with: 'https://example.com'
  click_button 'Create News Item'
end

Then('I should see the created news item details') do
  expect(page).to have_content('New News Item')
  expect(page).to have_content('Description for the new news item.')
  expect(page).to have_link('https://example.com', href: 'https://example.com')
end

Then('I should see a success notice') do
  expect(page).to have_content('News item was successfully created.')
end

When('I visit the edit news item page') do
  visit edit_representative_my_news_item_path(@representative, @news_item)
end

When('I update the news item details') do
  fill_in 'news_item_title', with: 'Updated News Item'
  click_button 'Update News Item'
end

Then('I should see the updated news item details') do
  expect(page).to have_content('Updated News Item')
end

When('I visit the news items page') do
  visit representative_my_news_items_path(@representative)
end

When('I click the {string} button for the news item') do |button_text|
  click_link button_text
end

Then('I should not see the deleted news item') do
  expect(page).not_to have_content(@news_item.title)
end
