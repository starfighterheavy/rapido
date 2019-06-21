Feature: Empty resources
  As a controller,
  I want to allow POST requests without body params,
  So that objects can be created without params

  Background:
    Given I am Developer Alpha
    And I send and accept JSON

  Scenario: System allows POST request without params
    When I send a POST request to "/api/toolboxes/okaybox/empty_widgets?api_key=ABCDE" with the following:
    """
    """
    Then the JSON response should be:
    """
    {
      "status": "Well done!"
    }
    """
    And the response status should be "201"


