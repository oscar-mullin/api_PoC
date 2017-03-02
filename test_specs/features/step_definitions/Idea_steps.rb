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
  ideaAPI.getIdea(ideaAPI.findIdeaID(communityAPI.getCommunityID,idea))
end

And(/^I verify that Post Idea Response structure is the expected$/) do
  ideaAPI = IdeaAPI.new
  response_expected_message = ideaAPI.verifyPostIdeaResponseContract
  fail(ArgumentError.new("Error in Response Contract expected\n#{response_expected_message}")) unless response_expected_message == ''
end

When(/^I post an idea on "([^"]*)" community with Title: "([^"]*)", Category: "([^"]*)", Tags: "([^"]*)" and "([^"]*)" parameters$/) do |site_name, idea_title, category_title, tags, params|
  # Get Community ID
  communityAPI = CommunityAPI.new
  community_id = communityAPI.getCommunityID

  # Get Category ID
  categoryAPI = CategoryAPI.new
  category_id = categoryAPI.getCategoryID

  # Get response for the Rest API Call and print it raw
  ideaAPI = IdeaAPI.new
  suffix = (Time.now.to_f*1000).to_i.to_s
  idea_title = idea_title + ' ' + suffix
  ideaAPI.postIdea(community_id, idea_title, category_id, tags, params)
end