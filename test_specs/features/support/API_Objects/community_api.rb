class CommunityAPI
  @response_body = nil

  def initialize(role_user=nil)
    @apiUtil = APIUtil.new(role_user)
    @response_body = Array['links', 'id', 'title', 'type', 'visible', 'description', 'site_type']
  end

  # Method to execute GET call through API framework and retrieve details of a specific community.
  # community_id  : Community title to retrieve its details
  def getCommunity(community_id)
    url_base = @apiUtil.getURIBase + "/api/v1/communities/#{community_id}"
    response = @apiUtil.makeGetCall(url_base, nil, nil)
    return response
  end

  # Method to verify the contract of a GET call
  # response_contract : Response contract that will be compared with the expected contract for Community API
  def verifyResponseContract(response_contract)
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

end