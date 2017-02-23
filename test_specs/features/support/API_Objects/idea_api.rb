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
  #
  #     response = @apiUtil.makePostCall(url_base, headers, parameters)
  #     return response
  #   end
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