Feature: Controllers that require no authority

  Background:
    Given I am Messages Developer
    And I send and accept JSON

  Scenario: Post a message
    When I send a POST request to "/api/comlinks/123/messages" with the following:
    """
    {
      "content": "How's Aldaaran?"
    }
    """
    Then the JSON response should be:
    """
    {
      "content": "How's Aldaaran?"
    }
    """
    And the response status should be "201"
