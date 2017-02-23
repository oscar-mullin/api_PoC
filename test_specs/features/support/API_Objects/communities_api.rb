class CommunitiesAPI
  RESPONSE_BODY_STRUCTURE = Array['total_count', 'links', 'content']

  def initialize(role_user=nil)
    @apiUtil = APIUtil.new(role_user)
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

  def getAllCommunities(params)
    url_base = @apiUtil.getURIBase + '/api/v1/communities'
    response = @apiUtil.makeGetCall(url_base, nil, params)
    return response
  end

  # Method to verify the contract of a GET call
  # response_contract : Response contract that will be compared with the expected contract for Communities API
  def verifyResponseContract(response_contract)
    final_message = ''
    response_content = JSON.parse(response_contract)
    if response_content.size == RESPONSE_BODY_STRUCTURE.size
      response_content.each do |key, _|
        unless RESPONSE_BODY_STRUCTURE.include?(key)
          final_message = "Element: #{key} was not expected, expected keys are: #{RESPONSE_BODY_STRUCTURE}"
          break
        end
      end
    else
      final_message = "Elements found: #{response_content.keys}\nElements expected: #{RESPONSE_BODY_STRUCTURE}"
    end
    return final_message
  end

end