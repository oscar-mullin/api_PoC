Feature: APITest

  # API calls test executed over Engage API framework
  @API
  Scenario Outline: API - List Communities
    Given I create a new token with "admin" role
    Then I get all the communities with "<params>" parameters
  Examples:
    | params           |
    | offset:0,limit:5 |

  @API
  Scenario Outline: API - Get specific Community
    Given I get the details of "<site>" community
  Examples:
    | site      |
    | QAArComm1 |

  @API
  Scenario Outline: API - Get Categories from a specific Community
    Given I create a new token with "member" role
    Then I get the categories of "<site>" community with "<params>" parameters
  Examples:
    | site      | params           |
    | QAArComm1 | offset:0,limit:5 |

  @API
  Scenario Outline: API - Get Ideas from a specific Community
    Given I get the ideas of "<site>" community with "<params>" parameters
  Examples:
    | site      | params           |
    | QAArComm1 | offset:0,limit:5 |

  @API
  Scenario Outline: API - Get specific Idea
    Given I get the details of "<idea_title>" idea on "<site>" community
  Examples:
    | site      | idea_title        |
    | QAArComm1 | Testing Post Idea |

  @API
  Scenario Outline: API - Get Idea Template from a specific Community
    Given I create a new token with "admin" role
    Then I get the Idea Template of "<site>" community
  Examples:
    | site      |
    | QAArComm1 |

  Scenario Outline: API - Post an idea
    Given I create a new token with "member" role
    Then I post an idea on "<site>" community with Title: "<title>", Category: "<category>", Tags: "<tags>" and "<params>" parameters
  Examples:
    | site      | title                   | category | tags | params                   |
    | QAArComm1 | Idea posted from API #5 | Science  |      | Content:Idea Description |
