Given(/^I get the categories of "([^"]*)" community with "([^"]*)" parameters$/) do |site_name, params|
  community_api = CommunityAPI.new(nil)
  categoryAPI = CategoryAPI.new

  categoryAPI.getAllCategories(community_api.getCommunityID,params)
end

And(/^I verify Categories Response structure is the expected$/) do
  category_api = CategoryAPI.new(nil)

  response_expected_message = category_api.verifyCategoriesResponseContract
  fail(ArgumentError.new("Error in Response Contract expected\n#{response_expected_message}")) unless response_expected_message == ''
end