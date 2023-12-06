Feature: Search for representatives using the CivicInfo API

  Scenario: Search for representatives by address
    Given I am on the representatives page
    When I enter the address "California"
    And I click the search button
    Then I should be on the search page

  Scenario: Search with an invalid address
    Given I am on the representatives page
    When I enter an invalid address
    And I click the search button