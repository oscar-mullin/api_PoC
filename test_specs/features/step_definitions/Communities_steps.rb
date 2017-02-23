require_relative '../support/API_Objects/community_api'
Then(/^I get all the communities with offset (.*) and limit (.*) parameters$/) do |offset, limit|
  communityAPI = CommunityAPI.new
  if offset != '' and limit != ''
    communityAPI.getAllCommunities("offset:#{offset},limit:#{limit}")
  elsif offset == '' and limit != ''
    communityAPI.getAllCommunities("limit:#{limit}")
  elsif offset != '' and limit == ''
    communityAPI.getAllCommunities("offset:#{offset}")
  else
    communityAPI.getAllCommunities("")
  end
end

And(/^I verify List Communities Response structure is the expected$/) do
  community_api = CommunityAPI.new
  response_expected_message = community_api.verifyCommunitiesResponseContract(community_api.getResponseData('body'))
  fail(ArgumentError.new("Error in Response Contract expected\n#{response_expected_message}")) unless response_expected_message == ''
end

And(/^I verify Community Response structure is the expected$/) do
  community_api = CommunityAPI.new
  response_expected_message = community_api.verifyResponseContract($responseGet.body)
  fail(ArgumentError.new("Error in Response Contract expected\n#{response_expected_message}")) unless response_expected_message == ''
end

And(/^I verify that Post Idea Response structure is the expected$/) do
  post_idea_api = PostIdeaAPI.new
  response_expected_message = post_idea_api.verifyResponseContract($responseGet.body)
  fail(ArgumentError.new("Error in Response Contract expected\n#{response_expected_message}")) unless response_expected_message == ''
end