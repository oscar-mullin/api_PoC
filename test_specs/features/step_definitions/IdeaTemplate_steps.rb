Given(/^I get the Idea Template of "([^"]*)" community$/) do |site_name|
  communityAPI = CommunityAPI.new

  # Get response for the Rest API Call and print it raw
  ideaTemplateAPI = IdeaTemplateAPI.new
  ideaTemplateAPI.getIdeaTemplate(communityAPI.getCommunityID)
end

And(/^I verify Idea Template Response structure is the expected$/) do
  idea_template_api = IdeaTemplateAPI.new(nil)

  response_expected_message = idea_template_api.verifyIdeaTemplateResponseContract
  fail(ArgumentError.new("Error in Response Contract expected\n#{response_expected_message}")) unless response_expected_message == ''
end