Feature: Toolboxes

  Background:
    Given I am Ben Franklin
    And Martha Washington exists
    And I go to the new user session page
    And I fill in "Email" with "ben@franklin.com"
    And I fill in "Password" with "Password1"
    And I press "Log in"

  Scenario: User can see all toolboxes
    Then I should see "Okay Toolbox"

  Scenario: User can create toolbox
    When I click on "New Toolbox"
    And I fill in "Name" with "Great Toolbox"
    And I press "Save"
    Then I should see "Great Toolbox"

  Scenario: System prevents a new toolbox without a name
    When I click on "New Toolbox"
    And I fill in "Name" with ""
    And I press "Save"
    Then I should see "Name can't be blank"

  Scenario: User can view toolbox
    When I follow "Okay Toolbox"
    And I should see "Okay Toolbox"

  Scenario: User cannot view another user's toolbox
    When I go directly to "/toolboxes/besttoolbox"
    Then I should see "The page you were looking for doesn't exist."

  Scenario: User can view toolbox
    When I follow "Okay Toolbox"
    And I should see "Okay Toolbox"

  Scenario: User can edit and update a toolbox
    When I follow "Okay Toolbox"
    And I click on "Edit"
    And I fill in "Name" with "Slightly Better Toolbox"
    And I press "Save"
    Then I should see "Slightly Better Toolbox"

  Scenario: System prevents invalid update
    When follow "Okay Toolbox"
    When I click on "Edit"
    And I fill in "Name" with ""
    And I press "Save"
    Then I should see "Name can't be blank"
