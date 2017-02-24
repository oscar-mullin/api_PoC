Feature: Communities

  @API
  Scenario Outline: API - ENGA-120/001 - Community - get Community
    Given I create a new token with "<role>" role
    When I get the details of "<site>" community
    Then I verify Get response is <response_code>
    And I verify Community Response structure is the expected
    Examples:
      | site      | role   | response_code |
      | QAArComm1 | admin  | 200           |
      | QAArComm1 | member | 200           |

  @API
  Scenario Outline: API - ENGA-121/001 - Community - Invalid Site Name
    Given I create a new token with "<role>" role
    When I get the details of "<site>" community
    Then I verify Get response is <response_code>
    Examples:
      | site       | role   | response_code |
      | NoSiteHere | admin  | -             |

  @API
  Scenario Outline: API - ENGA-121/001 - Community - Invalid ID
    Given I create a new token with "<role>" role
    When I get the details of "<site>" community
    Then I verify Get response is <response_code>
    Examples:
      | site   | role   | response_code |
      | NoSite | admin  | 200           |
