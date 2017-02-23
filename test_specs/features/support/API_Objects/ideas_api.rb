class IdeasAPI
  RESPONSE_BODY_STRUCTURE = Array['total_count', 'links', 'content']

  def initialize(role_user=nil)
    @apiUtil = APIUtil.new(role_user)
  end

  # Method to retrieve ID of a specific idea
  # idea_title : Title of the idea to retrieve its ID
  def getIdeaID(community_id, idea_title)
    idea_id = ''
    idea_found = false
    no_next_link = false
    offset = 0

    until idea_found or no_next_link
      ideas_response = getAllIdeas(community_id,"offset:#{offset},limit:100")
      response_content = JSON.parse(ideas_response.body)['content']
      idea = response_content.select{|h1| h1['title'] == idea_title}.first
      idea_found = !(idea.nil?)
      idea_id = idea['id'] if idea_found
      no_next_link = !((JSON.parse(ideas_response.body)['links'].select{|h1| h1['rel'] == 'next'}).nil?)
      offset += 100 unless no_next_link
    end

    return idea_id
  end

  # Method to execute GET call through API framework and retrieve a list of all the ideas on a specific community.
  # community_id  : Community ID to retrieve its ideas
  # params        : Parameters that will be added to URI's body
  def getAllIdeas(community_id, params)
    url_base = @apiUtil.getURIBase + "/api/v1/communities/#{community_id}/ideas"
    response = @apiUtil.makeGetCall(url_base, nil, params)
    return response
  end

  # Method to verify the contract of a GET call
  # response_contract : Response contract that will be compared with the expected contract for Ideas API
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