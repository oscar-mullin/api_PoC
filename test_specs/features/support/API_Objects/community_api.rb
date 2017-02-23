require_relative '../../support/lib/APIUtil'
class CommunityAPI < APIUtil
  @response_body = nil
  RESPONSE_BODY_STRUCTURE = Array['total_count', 'links', 'content']

  def initialize(role_user=nil)
    super(role_user)
    @response_body = Array['links', 'id', 'title', 'type', 'visible', 'description', 'site_type']
  end

  # Method to execute GET call through API framework and retrieve details of a specific community.
  # community_id  : Community title to retrieve its details
  def getCommunity(community_id)
    url_base = getURIBase + "/api/v1/communities/#{community_id}"
    response = makeGetCall(url_base, nil, nil)
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
      response_content = JSON.parse(communities_response)['content']
      community = response_content.select{|h1| h1['title'] == site_name}.first
      community_found = !(community.nil?)
      community_id = community['id'] if community_found
      no_next_link = !((JSON.parse(communities_response)['links'].select{|h1| h1['rel'] == 'next'}).size == 1)
      offset += 100 unless no_next_link
    end

    if community_id == ''
      fail(ArgumentError.new("'#{site_name}' site was not found."))
    else
      return community_id
    end
  end

  def getAllCommunities(params)
    url_base = getURIBase + '/api/v1/communities'
    response = makeGetCall(url_base, nil, params)
    return response
  end

  # Method to verify the contract of a GET call
  # response_contract : Response contract that will be compared with the expected contract for Community API
  def verifyCommunityResponseContract(response_contract)
    final_message = ''
    response_content = JSON.parse(response_contract)
    if response_content['site_type'] == 'REGULAR'
      @response_body.push('status')
    elsif response_content['site_type'] == 'CHALLENGE'
      @response_body.push('challenge_status')
      @response_body.push('start_date')
      @response_body.push('end_date')
      @response_body.push('logo')
      @response_body.push('phases')
    end

    if response_content.has_key?('parent_id')
      @response_body.push('parent_id') if response_content['parent_id'].to_i > 0
    end

    if response_content.size == @response_body.size
      response_content.each do |key, _|
        unless @response_body.include?(key)
          final_message = "Element: #{key} was not expected, expected keys are: #{@response_body}"
          break
        end
      end
    else
      final_message = "Elements found: #{response_content.keys}\nElements expected: #{@response_body}"
    end
    return final_message
  end

  # Method to verify the contract of a GET call
  # response_contract : Response contract that will be compared with the expected contract for Communities API
  def verifyCommunitiesResponseContract(response_contract)
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