Feature: Communities

  @API
  Scenario Outline: API - ENGA-118/001 - Communities - offset & limit - VALID
    Given I get all the communities with offset <offset> and limit <limit> parameters
    Then I verify Get response is <response>
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
  Scenario Outline: API -  ENGA-119/001 - Communities - offset & limit - INVALID PARAMS
    Given I get all the communities with offset <offset> and limit <limit> parameters
    Then I verify Get response is <response>
    Examples:
      | offset | limit | response |
      | 1000   | 10    | 400      |
      | -1     | 10    | 500      |
      | 0      | 0     | 400      |
      | 0      | -1    | 500      |
