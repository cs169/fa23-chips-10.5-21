# features/representative_profile.feature

Feature: Display government representative profile

  Scenario: View representative details on the profile page
    Given there is a government representative named "John Doe"
    When I visit the profile page for "John Doe"
    Then I should see the representative's name "John Doe"
    And I should see the representative's party
    And I should see the representative's address
    And I should see the representative's image

  Scenario: View representative details without an image
    Given there is a government representative named "Jane Smith" without an image
    When I visit the profile page for "Jane Smith"
    Then I should see the representative's name "Jane Smith"
    And I should see the representative's party
    And I should see the representative's address
    And I should not see an image of the representative

  Scenario: View representative details with missing information
    Given there is a government representative named "Bob Johnson" with missing party and address
    When I visit the profile page for "Bob Johnson"
    Then I should see the representative's name "Bob Johnson"
    And I should not see the representative's party
    And I should not see the representative's address
    And I should see the representative's image
