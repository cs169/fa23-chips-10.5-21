Given(/^I am on the map page$/) do
  visit '/state/CA'  
end

Then(/^I should see the map$/) do
  expect(page).to have_selector('#actionmap-info-box')  
end

When(/^I click on the county "([^"]*)"$/) do |county_name|
  within('actionmap-info-box', text: county_name) do
    find('path').click
  end
end

Then(/^I should be redirected to the search page for "([^"]*)"$/) do |address|
  expect(current_path).to eq("/search?address=#{CGI.escape(address)}")
end

When(/^I hover over the county "([^"]*)"$/) do |county_name|
  within('actionmap-info-box', text: county_name) do
    find('path').hover
  end
end

Then(/^I should see information for "([^"]*)"$/) do |county_info|
  expect(page).to have_content(county_info)
end