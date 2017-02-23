class IdeaAPI

  RESPONSE_BODY_STRUCTURE = Array['id', 'title', 'content', 'anon_flag', 'subscribed_by_current_user', 'parentid',
                                  'parent_title','creator_id','links','content_list']

  def initialize(role_user=nil)
    @apiUtil = APIUtil.new(role_user)
  end

  # Method to execute GET call through API framework and retrieve details of a specific idea.
  # idea_title  : Community title to retrieve its details
  def getIdea(idea_id)
    url_base = @apiUtil.getURIBase + "/api/v1/ideas/#{idea_id}"
    response = @apiUtil.makeGetCall(url_base, nil, nil)
    return response
  end

  # # Method to execute POST call through API framework to post an idea to a specific community
  # # community_id    : Community's id where the idea will be posted
  # # idea_title      : Title for the idea to be posted
  # # category_id     : Category's id where the idea will be posted
  # # tags            : Tags for the idea
  # # header          : Parameters that will be added to URI's headers
  # # params          : Parameters that will be added to URI's body
  # def postIdea(community_id, idea_title, category_id, tags, params)
  #
  #   url_base = "#{@apiUtil.getURIBase}/api/v1/communities/#{community_id}/ideas"
  #
  #   headers = Hash.new
  #   headers['Content-Type'] = 'application/json'
  #
  #   parameters = Hash.new
  #   parameters['title'] = idea_title
  #   parameters['category_id'] = category_id.to_i
  #   parameters['tags'] = tags.nil? ? '' : tags
  #
  #   # if no params were sent then no need to add an empty hash
  #   unless params.nil? or params == ''
  #     parameters['template_fields'] = @apiUtil.__parseStringToHash__(params)
  #   end
  #
  #   response = @apiUtil.makePostCall(url_base, headers, parameters)
  #   return response
  # end
  #
  # # Method to retrieve ID of a specific Idea
  # # community_id : ID of the community to retrieve the idea ID
  # # idea_title   : Title of the idea to retrieve its ID
  # def getIdeaID(community_id, idea_title)
  #   idea_id = ''
  #   idea_found = false
  #   no_next_link = false
  #   offset = 0
  #
  #   until idea_found or no_next_link
  #     ideas_response = getAllIdeas(community_id, "offset:#{offset},limit:100")
  #     response_content = JSON.parse(ideas_response.body)['content']
  #     idea = response_content.select{|h1| h1['title'] == idea_title}.first
  #     idea_found = !(idea.nil?)
  #     idea_id = idea['id'] if idea_found
  #     no_next_link = !((JSON.parse(ideas_response.body)['links'].select{|h1| h1['rel'] == 'next'}).nil?)
  #     offset += 100 unless no_next_link
  #        end
  #
  #   return idea_id
  # end

  # Method to verify the contract of a GET call
  # response_contract : Response contract that will be compared with the expected contract for Idea API
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