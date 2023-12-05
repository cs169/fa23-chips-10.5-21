# frozen_string_literal: true

# features/step_definitions/representative_steps.rb

Given('there is a government representative named {string}') do |representative_name|
  # Assuming you have a way to create a representative in your system
  @representative = Representative.create(
    name:           representative_name,
    party:          'Democrat',
    address_street: '1231 Kingside',
    address_city:   'Berkeley',
    address_state:  'CA',
    address_zip:    '382910',
    photo_url:      'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fi.ytimg.com%2Fvi%2FjcDS_EKJfsQ%2Fmaxresdefault.jpg&f=1&nofb=1&ipt=2dfff98fd915c703799242f1fff97c691dae1200f2b1a3444091381b3b2a4789&ipo=images'
  )
end

Given('there is a government representative named {string} without an image') do |representative_name|
  # Assuming you have a way to create a representative without an image in your system
  @representative = Representative.create(
    name:           representative_name,
    party:          'Democrat',
    address_street: '1231 Kingside',
    address_city:   'Berkeley',
    address_state:  'CA',
    address_zip:    '382910',
    photo_url:      nil
  )
end

Given('there is a government representative named {string} with missing party and address') do |representative_name|
  # Assuming you have a way to create a representative with missing party and address in your system
  @representative = Representative.create(
    name:           representative_name,
    party:          nil,
    address_street: '',
    address_city:   '',
    address_state:  '',
    address_zip:    '',
    photo_url:      'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fi.ytimg.com%2Fvi%2FjcDS_EKJfsQ%2Fmaxresdefault.jpg&f=1&nofb=1&ipt=2dfff98fd915c703799242f1fff97c691dae1200f2b1a3444091381b3b2a4789&ipo=images'
  )
end

When('I visit the profile page for {string}') do |_representative_name|
  # Assuming you have a route and controller action that renders the representative's profile page
  visit representative_path(@representative)
end

Then('I should see the representative\'s name {string}') do |representative_name|
  expect(page).to have_content(representative_name)
end

Then('I should see the representative\'s party') do
  # Assuming you have a method to retrieve the representative's party on the page
  expect(page).to have_content(@representative.party)
end

Then('I should see the representative\'s address') do
  # Assuming you have a method to retrieve the representative's address on the page
  unless @representative[:address_street].nil? || (@representative[:address_street] == '')
    expect(page).to have_content(@representative[:address_street])
  end
  unless @representative[:address_city].nil? || (@representative[:address_city] == '')
    expect(page).to have_content(@representative[:address_city])
  end
  unless @representative[:address_state].nil? || (@representative[:address_state] == '')
    expect(page).to have_content(@representative[:address_state])
  end
  unless @representative[:address_zip].nil? || (@representative[:address_zip] == '')
    expect(page).to have_content(@representative[:address_zip])
  end
end

Then('I should see the representative\'s image') do
  # Assuming you have a method to check for the presence of the representative's image on the page
  expect(page).to have_css('.representative-image')
end

Then('I should not see an image of the representative') do
  # Assuming you have a method to check for the absence of the representative's image on the page
  expect(page).not_to have_css('.representative-image')
end

Then('I should not see the representative\'s party') do
  # Assuming you have a method to check for the absence of the representative's party on the page
  expect(page).not_to have_content('Democrat')
  expect(page).not_to have_content('Republican')
  expect(page).not_to have_content('Green')
  expect(page).not_to have_content('Libertarian')
  expect(page).not_to have_content('Nonpartisan')
end

Then('I should not see the representative\'s address') do
  # Assuming you have a method to check for the absence of the representative's address on the page
  expect(page).not_to have_css('.address_street')
  expect(page).not_to have_css('.address_city')
  expect(page).not_to have_css('.address_state')
  expect(page).not_to have_css('.address_zip')
end
