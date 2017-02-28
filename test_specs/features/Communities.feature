Feature: Community

  @API
  Scenario Outline: API - ENGA-118/001 - Communities - offset & limit - VALID
    Given I create a new token with "admin" role
    When I get all the communities with offset <offset> and limit <limit> parameters
    Then I verify Get response is <response>
    And I verify List Communities Response structure is the expected
    Examples:
      | offset | limit | response |
      | 0      | 10    | 200      |
      | 1      | 10    | 200      |
      | 1      | 100   | 200      |
      | 0      | 1000  | 200      |
      |        | 10    | 200      |
      | 0      |       | 200      |
      |        |       | 200      |

  @API
  Scenario Outline: API -  ENGA-119/001 - Communities - offset & limit - Invalid Params
    Given I create a new token with "admin" role
    When I get all the communities with offset <offset> and limit <limit> parameters
    Then I verify Get response is <response>
    Examples:
      | offset | limit | response |
      | 1000   | 10    | 400      |
      | -1     | 10    | 500      |
      | 0      | 0     | 400      |
      | 0      | -1    | 500      |

  @API
  Scenario Outline: API -  ENGA-119/002 - Communities - offset & limit - Restricted User
    Given I create a new token with "member" role
    When I get all the communities with offset <offset> and limit <limit> parameters
    Then I verify Get response is <response>
    Examples:
      | offset | limit | response |
      | 0      | 10    | 200      |

  @API
  Scenario Outline: API -  ENGA-119/003 - Communities - offset & limit - Unauthorized User
    Given I create a new token with "none" role
    When I get all the communities with offset <offset> and limit <limit> parameters
    Then I verify Get response is <response>
    Examples:
      | offset | limit | response |
      | 0      | 10    | 401      |

  @API
  Scenario Outline: API - ENGA-120/001 - Community - get Community
    Given I create a new token with "<role>" role
    When I retrieve the "<site>" community ID
    And I get "<site>" community details
    Then I verify Get response is <response_code>
    And I verify Community Response structure is the expected
    Examples:
      | site      | role   | response_code |
      | QAArComm1 | admin  | 200           |
      | QAArComm1 | member | 200           |

  @API
  Scenario Outline: API - ENGA-121/001 - Community - Invalid Site Name
    Given I create a new token with "<role>" role
    When I retrieve the "<site>" community ID
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
