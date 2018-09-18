Feature: Controllers that require no authority and use a presenter

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
      "content": "How's Aldaaran?",
      "id": 1
    }
    """
    And the response status should be "201"
    When I send a GET request to "/api/comlinks/123/messages/1"
    Then the JSON response should be:
    """
    {
      "content": "How's Aldaaran?",
      "id": 1
    }
    """
    When I send a GET request to "/api/comlinks/123/messages"
    Then the JSON response should be:
    """
    [
      {
        "content": "How's Aldaaran?",
        "id": 1
      }
    ]
    """
    When I send a PATCH request to "/api/comlinks/123/messages/1" with the following:
    """
    {
      "content": "How is Aldaaran?"
    }
    """
    Then the JSON response should be:
    """
    {
      "content": "How is Aldaaran?",
      "id": 1
    }
    """
    When I send a DELETE request to "/api/comlinks/123/messages/1"
    Then the JSON response should be:
    """
    {
      "content": "How is Aldaaran?",
      "id": 1
    }
    """
