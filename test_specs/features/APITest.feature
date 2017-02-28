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
    | offset:0,limit:5 | 200           |member|
    | offset:0,limit:5 | 200           |superadmin|
    | offset:0,limit:5 | 200           |member|
    | offset:0,limit:5 | 200           |superadmin|
    | offset:0,limit:5 | 200           |member|
    | offset:0,limit:5 | 200           |superadmin|
    | offset:0,limit:5 | 200           |member|
    | offset:0,limit:5 | 200           |superadmin|
    | offset:0,limit:5 | 200           |member|
    | offset:0,limit:5 | 200           |superadmin|
    | offset:0,limit:5 | 200           |member|
    | offset:0,limit:5 | 200           |superadmin|
    | offset:0,limit:5 | 200           |member|
    | offset:0,limit:5 | 200           |superadmin|
    | offset:0,limit:5 | 200           |member|
    | offset:0,limit:5 | 200           |superadmin|
    | offset:0,limit:5 | 200           |member|
    | offset:0,limit:5 | 200           |superadmin|
    | offset:0,limit:5 | 200           |member|
    | offset:0,limit:5 | 200           |superadmin|
    | offset:0,limit:5 | 200           |member|
    | offset:0,limit:5 | 200           |superadmin|
    | offset:0,limit:5 | 200           |member|
    | offset:0,limit:5 | 200           |superadmin|
    | offset:0,limit:5 | 200           |member|
    | offset:0,limit:5 | 200           |superadmin|
    | offset:0,limit:5 | 200           |member|
    | offset:0,limit:5 | 200           |superadmin|
    | offset:0,limit:5 | 200           |member|
    | offset:0,limit:5 | 200           |superadmin|
    | offset:0,limit:5 | 200           |member|
    | offset:0,limit:5 | 200           |superadmin|
    | offset:0,limit:5 | 200           |member|
    | offset:0,limit:5 | 200           |superadmin|
    | offset:0,limit:5 | 200           |member|
    | offset:0,limit:5 | 200           |superadmin|
    | offset:0,limit:5 | 200           |member|
    | offset:0,limit:5 | 200           |superadmin|
    | offset:0,limit:5 | 200           |member|
    | offset:0,limit:5 | 200           |superadmin|
    | offset:0,limit:5 | 200           |member|
    | offset:0,limit:5 | 200           |superadmin|
    | offset:0,limit:5 | 200           |member|
    | offset:0,limit:5 | 200           |superadmin|
    | offset:0,limit:5 | 200           |member|
    | offset:0,limit:5 | 200           |superadmin|
    | offset:0,limit:5 | 200           |member|
    | offset:0,limit:5 | 200           |superadmin|
    | offset:0,limit:5 | 200           |member|
    | offset:0,limit:5 | 200           |superadmin|
    | offset:0,limit:5 | 200           |member|
    | offset:0,limit:5 | 200           |superadmin|
    | offset:0,limit:5 | 200           |member|
    | offset:0,limit:5 | 200           |superadmin|
    | offset:0,limit:5 | 200           |member|
    | offset:0,limit:5 | 200           |superadmin|
    | offset:0,limit:5 | 200           |member|
    | offset:0,limit:5 | 200           |superadmin|
    | offset:0,limit:5 | 200           |member|
    | offset:0,limit:5 | 200           |superadmin|
    | offset:0,limit:5 | 200           |member|
    | offset:0,limit:5 | 200           |superadmin|
    | offset:0,limit:5 | 200           |member|
    | offset:0,limit:5 | 200           |superadmin|
    | offset:0,limit:5 | 200           |member|
    | offset:0,limit:5 | 200           |superadmin|
    | offset:0,limit:5 | 200           |member|
    | offset:0,limit:5 | 200           |superadmin|
    | offset:0,limit:5 | 200           |member|
    | offset:0,limit:5 | 200           |superadmin|
    | offset:0,limit:5 | 200           |member|
    | offset:0,limit:5 | 200           |superadmin|
    | offset:0,limit:5 | 200           |member|
    | offset:0,limit:5 | 200           |superadmin|
    | offset:0,limit:5 | 200           |member|
    | offset:0,limit:5 | 200           |superadmin|
    | offset:0,limit:5 | 200           |member|
    | offset:0,limit:5 | 200           |superadmin|
    | offset:0,limit:5 | 200           |member|
    | offset:0,limit:5 | 200           |superadmin|
    | offset:0,limit:5 | 200           |member|
    | offset:0,limit:5 | 200           |superadmin|
    | offset:0,limit:5 | 200           |member|
    | offset:0,limit:5 | 200           |superadmin|
    | offset:0,limit:5 | 200           |member|
    | offset:0,limit:5 | 200           |superadmin|
    | offset:0,limit:5 | 200           |member|
    | offset:0,limit:5 | 200           |superadmin|
    | offset:0,limit:5 | 200           |member|
    | offset:0,limit:5 | 200           |superadmin|
    | offset:0,limit:5 | 200           |member|
    | offset:0,limit:5 | 200           |superadmin|
    | offset:0,limit:5 | 200           |member|
    | offset:0,limit:5 | 200           |superadmin|
    | offset:0,limit:5 | 200           |member|
    | offset:0,limit:5 | 200           |superadmin|
    | offset:0,limit:5 | 200           |member|
    | offset:0,limit:5 | 200           |superadmin|
    | offset:0,limit:5 | 200           |member|

