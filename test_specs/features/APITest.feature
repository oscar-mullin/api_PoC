Feature: APITest

  # API calls test executed over Engage API framework
  Scenario Outline: API - List Communities
    Given I get tokens
    Then I get all the communities with "<params>" parameters
  Examples:
    | params           |
    | offset:0,limit:5 |

  # API calls test executed to test 'rest-client' gem
  Scenario Outline: API - Get response testing
    Given I execute a GET command to "<url>" URL
  Examples:
    | url                                         |
    | http://jsonplaceholder.typicode.com/posts/1 |

  Scenario Outline: API - Get response testing with headers
    Given I execute a GET command to "<url>" URL with "<header>" header
  Examples:
    | url                                            | header           |
    | http://jsonplaceholder.typicode.com:80/posts/1 | offset:0,limit:5 |

  Scenario Outline: API - Post response testing with headers
    Given I execute a POST command to "<url>" URL with "<header>" header and "<body>" body
  Examples:
    | url                                          | header           | body                                       |
    | http://jsonplaceholder.typicode.com:80/posts | offset:0,limit:5 | data: {title: 'foo',body: 'bar',userId: 1} |
