# features/county_std_fips_code.feature

Feature: County std_fips_code method

  Scenario: Return a standardized FIPS code with leading zeros
    Given a county with FIPS code 1
    When I call the std_fips_code method
    Then it should return '001'

  Scenario: Return the original FIPS code if already three digits
    Given a county with FIPS code 123
    When I call the std_fips_code method
