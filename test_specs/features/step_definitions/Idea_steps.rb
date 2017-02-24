require_relative '../support/API_Objects/community_api'
require_relative '../support/API_Objects/idea_api'

Given(/^I get the ideas of "([^"]*)" community with "([^"]*)" parameters$/) do |_, params|
  ideaAPI = IdeaAPI.new
  communityAPI = CommunityAPI.new
  ideaAPI.getAllIdeas(communityAPI.getCommunityID,params)
end

And(/^I verify Ideas Response structure is the expected$/) do
  ideaAPI = IdeaAPI.new
  response_expected_message = ideaAPI.verifyIdeasResponseContract
  fail(ArgumentError.new("Error in Response Contract expected\n#{response_expected_message}")) unless response_expected_message == ''
end

And(/^I verify Idea Response structure is the expected$/) do
  ideaAPI = IdeaAPI.new
  response_expected_message = ideaAPI.verifyIdeaResponseContract
  fail(ArgumentError.new("Error in Response Contract expected\n#{response_expected_message}")) unless response_expected_message == ''
end

And(/^I get "([^"]*)" idea details of "([^"]*)" community$/) do |idea, _|
  ideaAPI = IdeaAPI.new
  communityAPI = CommunityAPI.new
  ideaAPI.findIdeaID(communityAPI.getCommunityID,idea)
end