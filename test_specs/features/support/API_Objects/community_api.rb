require_relative '../../support/lib/APIUtil'
class CommunityAPI < APIUtil
  
  @@community_id = '_'

  def initialize(role_user=nil)
    super(role_user)
    @community_response_structure = Array['links', 'id', 'title', 'type', 'visible', 'description', 'site_type', 'locked', 'can_delete', 'community_name', 'created_date']
    @communities_response_structure = Array['total_count', 'links', 'content']
  end
  
  def getCommunityID
    @@community_id
  end
  
  def setCommunityID(comm_id)
    @@community_id = comm_id
  end

  # Method to execute GET call through API framework and retrieve details of a specific community.
  # community_id  : Community title to retrieve its details
  def getCommunity(community_id)
    url_base = getURIBase + "/api/v1/communities/#{community_id}"
    makeGetCall(url_base, nil, nil)
  end

  # Method to retrieve ID of a specific Community
  # site_name : Title of the community to retrieve its ID
  def findCommunityID(site_name)
    community_found = false
    no_next_link = false
    offset = 0
    @@community_id = '_'

    until community_found or no_next_link
      getAllCommunities("offset:#{offset},limit:100")
      response_content = JSON.parse(@@response.body)['content']
      community = response_content.select{|h1| h1['title'] == site_name}.first
      community_found = !(community.nil?)
      @@community_id = community['id'] if community_found
      no_next_link = !((JSON.parse(@@response.body)['links'].select{|h1| h1['rel'] == 'next'}).size == 1)
      offset += 100 unless no_next_link
    end
      setCommunityID(@@community_id)
  end

  def getAllCommunities(params)
    url_base = URI_BASE + '/api/v1/communities'
    makeGetCall(url_base, nil, params)
  end

  # Method to verify the contract of a GET call for a specific Community
  def verifyCommunityResponseContract
    response_content = JSON.parse(@@response.body)
    if response_content['site_type'] == 'REGULAR'
      @community_response_structure.push('status')
    elsif response_content['site_type'] == 'CHALLENGE'
      @community_response_structure.push('challenge_status')
      @community_response_structure.push('start_date')
      @community_response_structure.push('end_date')
      @community_response_structure.push('logo')
      @community_response_structure.push('phases')
    end

    if response_content.has_key?('parent_id')
      @community_response_structure.push('parent_id') if response_content['parent_id'].to_i > 0
    end

    verifyResponseContract(@community_response_structure)
  end

  # Method to verify the contract of a GET call for all Communities
  def verifyCommunitiesResponseContract
    verifyResponseContract(@communities_response_structure)
  end

end