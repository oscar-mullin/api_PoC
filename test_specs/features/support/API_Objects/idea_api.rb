class IdeaAPI

  def initialize(role_user=nil)
    @apiUtil = APIUtil.new(role_user)
  end

  # Method to execute GET call through API framework and retrieve a list of all the ideas on a specific community.
  # community_id  : Community ID to retrieve its categories
  # params        : Parameters that will be added to URI's body
  def getAllIdeas(community_id, params)
    url_base = @apiUtil.getURIBase + "/api/v1/communities/#{community_id}/ideas"
    response = @apiUtil.makeGetCall(url_base, nil, params)
    return response
  end

  # Method to execute GET call through API framework and retrieve details of a specific idea.
  # idea_title  : Community title to retrieve its details
  def getIdea(community_id, idea_title)
    idea_id = getIdeaID(community_id, idea_title)
    url_base = @apiUtil.getURIBase + "/api/v1/ideas/#{idea_id}"
    response = @apiUtil.makeGetCall(url_base, nil, nil)
    return response
  end

  # Method to execute POST call through API framework to post an idea to a specific community
  # community_id    : Community's id where the idea will be posted
  # idea_title      : Title for the idea to be posted
  # category_id     : Category's id where the idea will be posted
  # tags            : Tags for the idea
  # header          : Parameters that will be added to URI's headers
  # params          : Parameters that will be added to URI's body
  def postIdea(community_id, idea_title, category_id, tags, params)

    url_base = "#{@apiUtil.getURIBase}/api/v1/communities/#{community_id}/ideas"

    headers = Hash.new
    headers['Content-Type'] = 'application/json'

    parameters = Hash.new
    parameters['title'] = idea_title
    parameters['category_id'] = category_id.to_i
    parameters['tags'] = tags.nil? ? '' : tags

    # if no params were sent then no need to add an empty hash
    unless params.nil? or params == ''
      parameters['template_fields'] = @apiUtil.__parseStringToHash__(params)
    end

    response = @apiUtil.makePostCall(url_base, headers, parameters)
    return response
  end

  # Method to retrieve ID of a specific Idea
  # community_id : ID of the community to retrieve the idea ID
  # idea_title   : Title of the idea to retrieve its ID
  def getIdeaID(community_id, idea_title)
    idea_id = ''
    idea_found = false
    no_next_link = false
    offset = 0

    until idea_found or no_next_link
      ideas_response = getAllIdeas(community_id, "offset:#{offset},limit:100")
      response_content = JSON.parse(ideas_response.body)['content']
      idea = response_content.select{|h1| h1['title'] == idea_title}.first
      idea_found = !(idea.nil?)
      idea_id = idea['id'] if idea_found
      no_next_link = !((JSON.parse(ideas_response.body)['links'].select{|h1| h1['rel'] == 'next'}).nil?)
      offset += 100 unless no_next_link
    end

    return idea_id
  end

end