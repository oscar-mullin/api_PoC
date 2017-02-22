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
  communities_api = CommunitiesAPI.new
  response_expected_message = communities_api.verifyResponseContract($responseGet.body)
  fail(ArgumentError.new("Error in Response Contract expected\n#{response_expected_message}")) unless response_expected_message == ''
end