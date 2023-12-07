Feature: Testing campaign_finances functionality

  Background:
    Given the campaign_finances active record has an entry for cycle "2020" and category "example"
    And you are on the search page

  Scenario: Submitting the form with a specific category and cycle
    When you submit the form with category "example" and cycle "2020"