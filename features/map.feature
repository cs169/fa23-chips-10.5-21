# features/map.feature

Feature: Map Functionality

  Scenario: Visiting the Map Page
    Given I am on the map page
    Then I should see the map

  Scenario: Clicking on a County
    Given I am on the map page
    When I click on the county "Los Angeles County"
    Then I should be redirected to the search page for "Los Angeles County, CA"

  Scenario: Hovering Over a County
    Given I am on the map page
    When I hover over the county "Los Angeles County"
    Then I should see information for "Los Angeles County, CA"