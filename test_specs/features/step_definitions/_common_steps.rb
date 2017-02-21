Given(/^I create a new token with "([^"]*)" role$/) do |role|
  @apiUtil = APIUtil.new(role)
end