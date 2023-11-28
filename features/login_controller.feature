Feature: User login and logout

  Scenario: Visit the login page
    Given I am on the login page
    Then I should see the login form

  Scenario: Log in with Google OAuth2
    Given I am on the login page
    When I click the "Login with Google" button
    Then I should be redirected to the Google login page

  Scenario: Log out
    Given I am logged in
    When I click the "Logout" button
    Then I should be logged out
    And I should be redirected to the home page
    And I should see a logout notice
