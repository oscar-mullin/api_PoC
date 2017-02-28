Feature: APITest

  # API calls test executed over Engage API framework
  @API
  Scenario Outline: API - List Communities
    Given I create a new token with "<user_role>" role
    When I get all the communities with "<params>" parameters
    Then I verify Get response is <response_code>
    And I verify List Communities Response structure is the expected
  Examples:
    | params           | response_code |user_role|
    | offset:0,limit:5 | 200           |superadmin|


  @API
  Scenario Outline: API - Get specific Community
    Given I create a new token with "<role>" role
    When I retrieve the "<site>" community ID
    And I get "<site>" community details
    Then I verify Get response is <response_code>
    And I verify Community Response structure is the expected
    Examples:
      | site      | role       | response_code |
      | QAArComm1 | superadmin | 200           |

  @API
  Scenario Outline: API - Get Categories from a specific Community
    Given I create a new token with "admin" role
    When I retrieve the "<site>" community ID
    Then I get the categories of "<site>" community with "<params>" parameters
    And I verify Get response is <response_code>
    And I verify Categories Response structure is the expected
    Examples:
      | site      | params           | response_code |
      | QAArComm1 | offset:0,limit:5 | 200           |

  @API
  Scenario Outline: API - Get Ideas from a specific Community
    Given I create a new token with "member" role
    When I retrieve the "<site>" community ID
    Then I get the ideas of "<site>" community with "<params>" parameters
    Then I verify Get response is <response_code>
    And I verify Ideas Response structure is the expected
    Examples:
      | site      | params           | response_code |
      | QAArComm1 | offset:0,limit:5 | 200           |

  @API
  Scenario Outline: API - Get specific Idea
    Given I create a new token with "<role>" role
    When I retrieve the "<site>" community ID
    And I get "<idea_title>" idea details of "<site>" community
    Then I verify Get response is <response_code>
    And I verify Idea Response structure is the expected
    Examples:
      | site      | role       | idea_title              | response_code |
      | QAArComm1 | superadmin | Idea posted from API #1 | 200           |

  @API
  Scenario Outline: API - Get Idea Template from a specific Community
    Given I create a new token with "admin" role
    When I retrieve the "<site>" community ID
    Then I get the Idea Template of "<site>" community
    And I verify Get response is <response_code>
    And I verify Idea Template Response structure is the expected
    Examples:
      | site      | response_code |
      | QAArComm1 | 200           |

  Scenario Outline: API - Post an idea
    Given I create a new token with "member" role
    When I retrieve the "<site>" community ID
    When I retrieve the "<category>" category ID of <site> community
    When I post an idea on "<site>" community with Title: "<title>", Category: "<category>", Tags: "<tags>" and "<params>" parameters
    Then I verify Get response is <response_code>
    And I verify that Post Idea Response structure is the expected
    Examples:
      | site      | title                    | category | tags | params                   | response_code |
      | QAArComm1 | Idea posted from API #15 | Science  |      | Content:Idea Description | 201           |
