Given(/^I create a new token with "([^"]*)" role$/) do |role|
  @apiUtil = APIUtil.new(role)
end

Then(/^I verify Get response is (.*)$/) do |expectedResponse|
  @apiUtil = APIUtil.new(nil)
  current_code = @apiUtil.getResponse.code
  fail(ArgumentError.new("Actual response: #{current_code}, Expected: #{expectedResponse}\nResponse Message: " + @apiUtil.getResponse.body)) unless current_code.to_i == expectedResponse.to_i
end

Then(/^I verify Post response is (.*)$/) do |expectedResponse|
  fail(ArgumentError.new("Actual response: #{$responsePost.code}, Expected: #{expectedResponse}\nResponse Message: " + @apiUtil.getResponse.body)) unless $responsePost.code.to_i == expectedResponse.to_i
end