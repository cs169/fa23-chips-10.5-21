# frozen_string_literal: true

# features/step_definitions/county_std_fips_code_steps.rb

Given(/^a county with FIPS code (\d+)$/) do |fips_code|
  @county = County.new(fips_code: fips_code.to_i)
end

When(/^I call the std_fips_code method$/) do
  @result = @county.std_fips_code
end

Then(/^it should return '(\d+)'$/) do |expected_result|
  expect(@result).to eq('001')
end
