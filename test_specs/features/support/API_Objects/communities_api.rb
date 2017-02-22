class CommunitiesAPI
  RESPONSE_BODY_STRUCTURE = Array['total_count', 'links', 'content']

  def initialize(role_user=nil)
    @apiUtil = APIUtil.new(role_user)
  end

  def getAllCommunities(params)
    url_base = @apiUtil.getURIBase + '/api/v1/communities'
    response = @apiUtil.makeGetCall(url_base, nil, params)
    return response
  end

  def verifyResponseContract(response_contract)
    final_message = ''
    response_content = JSON.parse(response_contract)
    puts "HERE: #{response_content} - #{RESPONSE_BODY_STRUCTURE}"
    if response_content.size == RESPONSE_BODY_STRUCTURE.size
      response_content.each do |key, _|
        puts "HERE1: #{key}"
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