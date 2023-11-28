Feature: Managing news items related to representatives

  Background:
    Given there is a representative in the system

  Scenario: Create a new news item
    When I visit the new news item page
    And I fill in the news item form
    And I click the "Create News Item" button
    Then I should see the created news item details
    And I should see a success notice

  Scenario: Edit an existing news item
    Given there is an existing news item
    When I visit the edit news item page
    And I update the news item details
    And I click the "Update News Item" button
    Then I should see the updated news item details
    And I should see a success notice

  Scenario: Delete an existing news item
    Given there is an existing news item
    When I visit the news items page
    And I click the "Delete" button for the news item
    Then I should see a success notice
    And I should not see the deleted news item

