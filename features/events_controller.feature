Feature: Displaying and filtering events

  Scenario: View all events
    Given there are some events in the system
    When I visit the events page
    Then I should see a list of events

  Scenario: View a specific event
    Given there is an event in the system
    When I visit the event page
    Then I should see details of the event

  Scenario: Filter events by state
    Given there are events in the system
    When I filter events by state
    Then I should see a list of events in that state

  Scenario: Filter events by county
    Given there are events in the system
    When I filter events by county
    Then I should see a list of events in that county

  Scenario: Filter events by state only
    Given there are events in the system
    When I filter events by state only
    Then I should see a list of events in that state
    And I should not see events from other states