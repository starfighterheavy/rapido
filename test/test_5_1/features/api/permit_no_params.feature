Feature: permit_no_params! and builder param
  As a controller,
  I want to allow POST requests without body params,
  So that objects can be created without params
  And I want to allow un-persisted objects by using a builder parameter for belongs_to,
  So that I can create objects outside of ActiveRecord (like business process objects).

  Background:
    Given I am Developer Alpha
    And I send and accept JSON

  Scenario: System allows POST request without params using a virtual
    When I send a POST request to "/api/toolboxes/okaybox/virtual_widgets?api_key=ABCDE" with the following:
    """
    """
    Then the JSON response should be:
    """
    {
      "status": "Well done!"
    }
    """
    And the response status should be "201"

