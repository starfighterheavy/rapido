Feature: Virtual resources
  As a controller,
  And I want to allow un-persisted objects by using a builder & finder options for belongs_to,
  So that I can create, update and delete objects outside of ActiveRecord (like business process objects).

  Background:
    Given I am Developer Alpha
    And I send and accept JSON

  Scenario: System allows POST request
    When I send a POST request to "/api/toolboxes/okaybox/virtual_widget?api_key=ABCDE" with the following:
    """
      {
        "name": "VirtualBoy"
      }
    """
    Then the JSON response should be:
    """
    {
      "name": "VirtualBoy"
    }
    """
    And the response status should be "201"

  Scenario: System allows PATCH request
    When I send a PATCH request to "/api/toolboxes/okaybox/virtual_widget?api_key=ABCDE" with the following:
    """
    {
      "name": "VirtualBoy"
    }
    """
    Then the JSON response should be:
    """
    {
      "name": "VirtualBoy"
    }
    """
    And the response status should be "200"


