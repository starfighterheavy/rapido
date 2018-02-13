Feature: Toolboxes

  Background:
    Given I am Ben Franklin
    And I go to the new user session page
    And I fill in "Email" with "ben@franklin.com"
    And I fill in "Password" with "Password1"
    And I press "Log in"

  Scenario: User can create a protocol droid
    When I visit "/user/protocol_droids/new"
    And I fill in "Name" with "GreatDroid"
    And I press "Save"
    Then I should see "GreatDroid"

  Scenario: System prevents a new protocol droid without a name
    When I visit "/user/protocol_droids/new"
    And I fill in "Name" with ""
    And I press "Save"
    Then I should see "Name can't be blank"

  Scenario: User can edit and update a toolbox
    When I visit "/user/protocol_droids/new"
    And I fill in "Name" with "GreatDroid"
    And I press "Save"
    And I visit "/user/protocol_droids/GreatDroid"
    And I click on "Edit"
    And I fill in "Name" with "SlightlyBetterDroid"
    And I press "Save"
    Then I should see "SlightlyBetterDroid"
