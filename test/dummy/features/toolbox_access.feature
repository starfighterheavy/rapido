Feature: Access control for child objects

  Background:
    Given Ben Franklin exists
    And Martha Washington exists

  Scenario: User can view their toolboxes
    When I go to the new user session page
    And I fill in "Email" with "martha@washington.com"
    And I fill in "Password" with "Password1"
    And I press "Log in"
    And I should see "besttoolbox"
    When I go directly to "/toolboxes/besttoolbox"
    And I should see "besttoolbox"

  Scenario: User cannot view another user's toolboxes
    When I go to the new user session page
    And I fill in "Email" with "ben@franklin.com"
    And I fill in "Password" with "Password1"
    And I press "Log in"
    And I should see "Okay Toolbox"
    When I go directly to "/toolboxes/besttoolbox"
    Then I should see "The page you were looking for doesn't exist."
