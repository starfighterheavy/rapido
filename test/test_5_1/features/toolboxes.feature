Feature: Toolboxes

  Background:
    Given I am Andy Developer
    And I send and accept JSON

  Scenario: System blocks access to api without proper api_key
    When I send a POST request to "/api/toolboxes?api_key=12345" with the following:
    """
    {
      "name": "greatbox"
    }
    """
    Then the JSON response should be:
    """
    {
      "error": "Invalid api_key."
    }
    """
    And the response status should be "401"

  Scenario: Post a toolbox
    When I send a POST request to "/api/toolboxes?api_key=ABCDE" with the following:
    """
    {
      "name": "greatbox"
    }
    """
    Then the JSON response should be:
    """
    {
      "name": "greatbox"
    }
    """
    And the response status should be "201"

  Scenario: Get all toolboxes
    Given Betsy Developer exists
    When I send a GET request to "/api/toolboxes?api_key=ABCDE" with the following:
    Then the response status should be "200"
    And the JSON response should be:
    """
    [
      {
        "name": "okaybox"
      }
    ]
    """

  Scenario: Get a toolbox
    When I send a GET request to "/api/toolboxes/okaybox?api_key=ABCDE"
    Then the response status should be "200"
    And the JSON response should be:
    """
    {
      "name": "okaybox"
    }
    """

  Scenario: Patch a toolbox
    When I send a PATCH request to "/api/toolboxes/okaybox?api_key=ABCDE" with the following:
    """
    {
      "name": "betterbox"
    }
    """
    Then the response status should be "200"
    And the JSON response should be:
    """
    {
      "name": "betterbox"
    }
    """

  Scenario: Delete a toolbox
    When I send a DELETE request to "/api/toolboxes/okaybox?api_key=ABCDE"
    Then the response status should be "200"
    And the JSON response should be:
    """
    {
      "name": "okaybox"
    }
    """
