Feature: APITest

  # API calls test executed over Engage API framework
  @API
  Scenario Outline: API - List Communities
    Given I get all the communities with "<params>" parameters

  Examples:
    | params           |
    | offset:0,limit:5 |
#    | offset:0,limit:5 |
#    | offset:0,limit:5 |
#    | offset:0,limit:5 |
#    | offset:0,limit:5 |
#
#  Scenario Outline: API - Post an idea
#    Given I post an idea on "<site>" community with "<params>" parameters in "<format>" format
#  Examples:
#    | site           | format                        | params                                                                   |
#    | Test Community | Content-Type:application/json | title:Idea From API,tags:Tag1,template_fields:{Content:Idea description} |
