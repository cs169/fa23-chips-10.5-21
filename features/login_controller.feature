Feature: User login and logout

  Scenario: Visit the login page
    Given I am on the login page
    Then I should see the login form

  Scenario: Log in with Google OAuth2
    Given I am on the login page
    When I click the "Sign in with GitHub" button
    Then I should be redirected to the map
