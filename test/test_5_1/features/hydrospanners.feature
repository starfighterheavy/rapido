Feature: Hydrospanners

  Background:
    Given I am Andy Developer
    And I send and accept JSON

  Scenario: System blocks access to api without proper api_key
    When I send a POST request to "/api/toolboxes/okaybox/hydrospanners?api_key=12345" with the following:
    """
    {
      "name": "greatspanner"
    }
    """
    Then the JSON response should be:
    """
    {
      "error": "Request denied."
    }
    """
    And the response status should be "401"

  Scenario: Post a Hydrospanner
    When I send a POST request to "/api/toolboxes/okaybox/hydrospanners?api_key=ABCDE" with the following:
    """
    {
      "name": "greatspanner"
    }
    """
    Then the JSON response should be:
    """
    {
      "name": "greatspanner"
    }
    """
    And the response status should be "201"

  Scenario: Get all Hydrospanners
    Given Betsy Developer exists
    When I send a GET request to "/api/toolboxes/okaybox/hydrospanners?api_key=ABCDE" with the following:
    Then the response status should be "200"
    And the JSON response should be:
    """
    [
      {
        "name": "okayspanner"
      }
    ]
    """

  Scenario: Get a Hydrospanner
    When I send a GET request to "/api/toolboxes/okaybox/hydrospanners/okayspanner?api_key=ABCDE"
    Then the response status should be "200"
    And the JSON response should be:
    """
    {
      "name": "okayspanner"
    }
    """

  Scenario: Patch a Hydrospanner
    When I send a PATCH request to "/api/toolboxes/okaybox/hydrospanners/okayspanner?api_key=ABCDE" with the following:
    """
    {
      "name": "betterspanner"
    }
    """
    Then the response status should be "200"
    And the JSON response should be:
    """
    {
      "name": "betterspanner"
    }
    """

  Scenario: Delete a Hydrospanner
    When I send a DELETE request to "/api/toolboxes/okaybox/hydrospanners/okayspanner?api_key=ABCDE"
    Then the response status should be "200"
    And the JSON response should be:
    """
    {
      "name": "okayspanner"
    }
    """
