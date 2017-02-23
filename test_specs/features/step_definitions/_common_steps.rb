Given(/^I create a new token with "([^"]*)" role$/) do |role|
  @apiUtil = APIUtil.new(role)
end

Then(/^I verify Get response is (.*)$/) do |expectedResponse|
  @apiUtil = APIUtil.new(nil)
  current_code = @apiUtil.getResponseData('code')
  fail(ArgumentError.new("Actual response: #{current_code}, Expected: #{expectedResponse}\n")) unless current_code.to_i == expectedResponse.to_i
end

Then(/^I verify Post response is (.*)$/) do |expectedResponse|
  fail(ArgumentError.new("Actual response: #{$responsePost.code}, Expected: #{expectedResponse}\n")) unless $responsePost.code.to_i == expectedResponse.to_i
end