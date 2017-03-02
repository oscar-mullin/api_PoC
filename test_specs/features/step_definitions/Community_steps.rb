require_relative '../support/API_Objects/community_api'

Given(/^I get all the communities with "([^"]*)" parameters$/) do |params|
  # Get response for the Rest API Call and print it raw
  communityAPI = CommunityAPI.new
  communityAPI.getAllCommunities(params)
end

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
  community_api = CommunityAPI.new(nil)
  response_expected_message = community_api.verifyCommunitiesResponseContract
  fail(ArgumentError.new("Error in Response Contract expected\n#{response_expected_message}")) unless response_expected_message == ''
end

And(/^I verify Community Response structure is the expected$/) do
  community_api = CommunityAPI.new(nil)
  response_expected_message = community_api.verifyCommunityResponseContract
  fail(ArgumentError.new("Error in Response Contract expected\n#{response_expected_message}")) unless response_expected_message == ''
end

When(/^I retrieve the "([^"]*)" community ID$/) do |site_name|
  # Get Community ID
  communityAPI = CommunityAPI.new
  communityAPI.findCommunityID(site_name)
  fail(ArgumentError.new("'#{site_name}' site was not found.")) unless communityAPI.getResponse.code == 200
end

And(/^I get "([^"]*)" community details$/) do |site|
  communityAPI = CommunityAPI.new
  communityAPI.getCommunity(communityAPI.getCommunityID)
end

And(/^I get community details of the site with "([^"]*)" ID$/) do |site_id|
  communityAPI = CommunityAPI.new
  communityAPI.getCommunity(site_id)
end