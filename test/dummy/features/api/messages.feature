Feature: Controllers that require no authority and use a presenter

  Background:
    Given I am Messages Developer

  Scenario: Post a message
    Given I set headers:
    |Content-Type|application/json|
    |Accept|application/json|
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
    When I send a GET request to "/api/comlinks/123/messages/1.json?filename=download.json"
    Then the JSON response should be:
    """
    {
      "content": "How's Aldaaran?",
      "id": 1
    }
    """
    Given I set headers:
    |Content-Type|application/json|
    |Accept|application/xml|
    When I send a GET request to "/api/comlinks/123/messages/1.xml"
    Then the response should be:
    """
    <?xml version="1.0" encoding="UTF-8"?>
    <hash>
      <id type="integer">1</id>
      <content>How's Aldaaran?</content>
    </hash>

    """
    When I send a GET request to "/api/comlinks/123/messages/1.xml?filename=download.xml"
    Then the response should be:
    """
    <?xml version="1.0" encoding="UTF-8"?>
    <hash>
      <id type="integer">1</id>
      <content>How's Aldaaran?</content>
    </hash>

    """
    Given I set headers:
    |Content-Type|application/json|
    |Accept|text/csv|
    When I send a GET request to "/api/comlinks/123/messages/1.csv"
    Then the response should be:
    """
    id,content
    1,How's Aldaaran?
    
    """
    When I send a GET request to "/api/comlinks/123/messages/1.csv?filename=download.csv"
    Then the response should be:
    """
    id,content
    1,How's Aldaaran?
    
    """
    When I send a GET request to "/api/comlinks/123/messages?query=how"
    Then the response should be:
    """
    id,content
    1,How's Aldaaran?

    """
    Given I set headers:
    |Content-Type|application/json|
    |Accept|application/json|
    When I send a PATCH request to "/api/comlinks/123/messages/1" with the following:
    """
    {
      "content": "What?!"
    }
    """
    Then the JSON response should be:
    """
    {
      "content": "What?!",
      "id": 1
    }
    """
    When I send a GET request to "/api/comlinks/123/messages?query=how"
    Then the JSON response should be:
    """
    []
    """
    When I send a DELETE request to "/api/comlinks/123/messages/1"
    Then the JSON response should be:
    """
    {
      "content": "What?!",
      "id": 1
    }
    """
