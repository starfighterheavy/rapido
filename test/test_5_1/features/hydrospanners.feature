Feature: Hydrospanners

  Background:
    Given I am Ben Franklin
    And Martha Washington exists
    And I go to the new user session page
    And I fill in "Email" with "ben@franklin.com"
    And I fill in "Password" with "Password1"
    And I press "Log in"
    And I follow "Okay Toolbox"

  Scenario: User can see all hydrospanners for a toolbox
    When I follow "View Hydrospanners"
    And I should see "mediocrehydrospanner"

  Scenario: User can create a new hydrospanner for a toolbox and apply an after success filter
    When I follow "View Hydrospanners"
    And I follow "New Hydrospanner"
    And I fill in "Name" with "BetterHydrospanner"
    And I press "Save"
    Then I should see "Rendered text: BetterHydrospanner"

  Scenario: System prevents invalid create
    When I follow "View Hydrospanners"
    When I follow "New Hydrospanner"
    And I fill in "Name" with ""
    And I press "Save"
    Then I should see "Rendered text: Name can't be blank"

  Scenario: User can view hydrospanner
    When I follow "View Hydrospanners"
    And I follow "mediocrehydrospanner"
    And I should see "mediocrehydrospanner"

  Scenario: User can edit and update a hydospanner
    When I follow "View Hydrospanners"
    And I follow "mediocrehydrospanner"
    And I follow "Edit"
    And I fill in "Name" with "SlightlyBetterHydrospanner"
    And I press "Save"
    Then I should see "SlightlyBetterHydrospanner"

  Scenario: System prevents invalid update
    When I follow "View Hydrospanners"
    And I follow "mediocrehydrospanner"
    When I follow "Edit"
    And I fill in "Name" with ""
    And I press "Save"
    Then I should see "Name can't be blank"

  Scenario: User can delete a hydrospanner
    When I follow "View Hydrospanners"
    And I follow "mediocrehydrospanner"
    When I click on "Delete"
    Then I should see "Okay Toolbox"
    And I should not see "mediorehydrospanner"
