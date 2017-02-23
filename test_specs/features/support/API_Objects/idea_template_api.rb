class IdeaTemplateAPI

  RESPONSE_BODY_STRUCTURE = Array['acceptable_date_pattern', 'annonymous_allowed', 'post_idea_allowed', 'has_category', 'links', 'idea_template']

  def initialize(role_user=nil)
    @apiUtil = APIUtil.new(role_user)
  end

  # Method to retrieve Idea Template of a specific community.
  # community_id  : Community ID to retrieve its idea template
  def getIdeaTemplate(community_id)
    url_base = @apiUtil.getURIBase + "/api/v1/communities/#{community_id}/idea-template"
    response = @apiUtil.makeGetCall(url_base, nil, nil)
    return response
  end

  # Method to verify the contract of a GET call
  # response_contract : Response contract that will be compared with the expected contract for Idea Template API
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