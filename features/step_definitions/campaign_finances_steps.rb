Given("the campaign_finances active record has an entry for cycle {string} and category {string}") do |cycle, category|
  # Assuming you have a CampaignFinance record creation method here
  CampaignFinance.create!(cycle: cycle, category: category, candidates_list: ["Candidate1", "Candidate2"])
end

Given("you are on the search page") do
  # Assuming you have a method to navigate to the search page
  visit('/campaign_finances')
end

When("you submit the form with category {string} and cycle {string}") do |category, cycle|
  # Assuming you have a method to fill and submit the search form
  select cycle, from: 'cycle'
  find('#category').set(category)
  click_button 'Search'
end




# Then("you should see some names") do
#   # Assuming you have a method to check for the presence of candidate names in the results
#   expect(page).to have_content("Candidate1")
#   expect(page).to have_content("Candidate2")
# end
