Given(/^I create a new token with "([^"]*)" role$/) do |role|
  @apiUtil = APIUtil.new(role)
end

Then(/^I verify Get response is (.*)$/) do |expectedResponse|
  fail(ArgumentError.new("Actual response: #{$responseGet.code}, Expected: #{expectedResponse}\n")) unless $responseGet.code == expectedResponse
end

Then(/^I verify Post response is (.*)$/) do |expectedResponse|
  fail(ArgumentError.new("Actual response: #{$responsePost.code}, Expected: #{expectedResponse}\n")) unless $responsePost.code == expectedResponse
end