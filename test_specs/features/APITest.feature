Feature: APITest

  # API calls test executed over Engage API framework
  @API
  Scenario Outline: API - List Communities
    Given I create a new token with "member" role
    When I get all the communities with "<params>" parameters
    Then I verify Get response is <response_code>
    And I verify List Communities Response structure is the expected
  Examples:
    | params           | response_code |
    | offset:0,limit:5 | 200           |

  @API
  Scenario Outline: API - Get specific Community
    Given I create a new token with "<role>" role
    When I get the details of "<site>" community
    Then I verify the code response-->code
    And I verify that JSON response has expected contract-->contract
    And I verify that community title is "XXX" title--->content
  Examples:
    | site      | role   |
    | QAArComm1 | member |

  @API
  Scenario Outline: API - Get Categories from a specific Community
    Given I create a new token with "admin" role
    Then I get the categories of "<site>" community with "<params>" parameters
  Examples:
    | site      | params           |
    | QAArComm1 | offset:0,limit:5 |

  @API
  Scenario Outline: API - Get Ideas from a specific Community
    Given I create a new token with "member" role
    Then I get the ideas of "<site>" community with "<params>" parameters
  Examples:
    | site      | params           |
    | QAArComm1 | offset:0,limit:5 |

  @API
  Scenario Outline: API - Get specific Idea
    Given I post an idea on "<string>" community with Title: "<string>", Category: "<string>", Tags: "<string>" and "<string>" parameters
    Then I get the details of recently posted idea
  Examples:
    | site      | idea_title        |
    | QAArComm1 | Testing Post Idea |
    | QAArComm1 | Testing "#$"#$Post Idea1 |
    | QAArComm1 |  |
    | QAArComm1 | Testing Post Idea3Testing Post Idea3Testing Post Idea3Testing Post Idea3Testing Post Idea3Testing Post Idea3Testing Post Idea3 |
    | QAArComm1 | Te |

  @API
  Scenario Outline: API - Get Idea Template from a specific Community
    Given I create a new token with "admin" role
    Then I get the Idea Template of "<site>" community
  Examples:
    | site      |
    | QAArComm1 |

#  Scenario Outline: API - Post an idea
#    Given I create a new token with "member" role
##    When I get "<site>" community ID
##    And I get "<category>" category ID
#    When I post an idea on "<site>" community with Title: "<title>", Category: "<category>", Tags: "<tags>" and "<params>" parameters
##    Then
#  Examples:
#    | site      | title                   | category | tags | params                   |
#    | QAArComm1 | Idea posted from API #5 | Science  |      | Content:Idea Description |
