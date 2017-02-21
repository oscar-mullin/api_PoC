class CommunityAPI

  def initialize(role_user=nil)
    @apiUtil = APIUtil.new(role_user)
  end

  def getAllCommunities(params)
    url_base = @apiUtil.getURIBase + '/api/v1/communities'
    response = @apiUtil.makeGetCall(url_base, nil, params)
    return response
  end

  def getCommunity(site_name)
    community_id = getCommunityID(site_name)
    url_base = @apiUtil.getURIBase + "/api/v1/communities/#{community_id}"
    response = @apiUtil.makeGetCall(url_base, nil, nil)
    return response
  end

  # Method to retrieve ID of a specific Community
  # site_name : Title of the community to retrieve its ID
  def getCommunityID(site_name)
    community_id = ''
    community_found = false
    no_next_link = false
    offset = 0

    until community_found or no_next_link
      communities_response = getAllCommunities("offset:#{offset},limit:100")
      response_content = JSON.parse(communities_response.body)['content']
      community = response_content.select{|h1| h1['title'] == site_name}.first
      community_found = !(community.nil?)
      community_id = community['id'] if community_found
      no_next_link = !((JSON.parse(communities_response.body)['links'].select{|h1| h1['rel'] == 'next'}).nil?)
      offset += 100 unless no_next_link
    end

    return community_id
  end

end