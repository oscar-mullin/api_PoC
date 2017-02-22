require_relative '../support/API_Objects/community_api'
Then(/^I get all the communities with offset (.*) and limit (.*) parameters$/) do |offset, limit|
  communityAPI = CommunityAPI.new('admin')
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