class IdeaAPI < APIUtil

  @@idea_id = '_'

  def initialize(role_user=nil)
    super(role_user)
    @idea_response_structure = Array['id', 'title', 'content', 'anon_flag', 'subscribed_by_current_user', 'parentid',
                                     'parent_title','creator_id','links','content_list']
    @ideas_response_structure = Array['total_count', 'links', 'content']
    @postIdea_response_structure = Array['id','title','links']
  end

  def getIdeaID
    @@idea_id
  end

  def setIdeaID(idea_id)
    @@idea_id = idea_id
  end

  # Method to execute GET call through API framework and retrieve details of a specific idea.
  # idea_title  : Community title to retrieve its details
  def getIdea(idea_id)
    url_base = getURIBase + "/api/v1/ideas/#{idea_id}"
    makeGetCall(url_base, nil, nil)
  end

  # Method to retrieve ID of a specific Idea
  # community_id : ID of the community to retrieve the idea ID
  # idea_title   : Title of the idea to retrieve its ID
  def findIdeaID(community_id, idea_title)
    offset = 0
    limit = 100
    @@idea_id = '_'
    _findIdeaID(community_id, idea_title,offset, limit)
  end

  def _findIdeaID(community_id, idea_title,offset,limit)
    getAllIdeas(community_id, "offset:#{offset},limit:#{limit}")
    response_content = JSON.parse(@@response.body)['content']
    idea = response_content.select{|h1| h1['title'] == idea_title}.first
    idea_found = !(idea.nil?)
    if idea_found
      @@idea_id = idea['id']
    else
      no_next_link = !((JSON.parse(@@response.body)['links'].select{|h1| h1['rel'] == 'next'}).nil?)
      unless no_next_link
        _findIdeaID(community_id, idea_title,offset+limit,limit)
      end
    end
  end

  # Method to execute GET call through API framework and retrieve a list of all the ideas on a specific community.
  # community_id  : Community ID to retrieve its ideas
  # params        : Parameters that will be added to URI's body
  def getAllIdeas(community_id,params)
    url_base = URI_BASE + "/api/v1/communities/#{community_id}/ideas"
    makeGetCall(url_base, nil, params)
  end

  # Method to execute POST call through API framework to post an idea to a specific community
  # community_id    : Community's id where the idea will be posted
  # idea_title      : Title for the idea to be posted
  # category_id     : Category's id where the idea will be posted
  # tags            : Tags for the idea
  # header          : Parameters that will be added to URI's headers
  # params          : Parameters that will be added to URI's body
  def postIdea(community_id, idea_title, category_id, tags, params)

    url_base = "#{getURIBase}/api/v1/communities/#{community_id}/ideas"

    headers = Hash.new
    headers['Content-Type'] = 'application/json'

    parameters = Hash.new
    parameters['title'] = idea_title
    parameters['category_id'] = category_id.to_i
    parameters['tags'] = tags.nil? ? '' : tags
    parameters['post_anonymously'] = false

    # if no params were sent then no need to add an empty hash
    unless params.nil? or params == ''
      parameters['template_fields'] = APIClientWrapper.new.__parseStringToHash__(params)
    end

    makePostCall(url_base, headers, parameters)
  end

  # Method to verify the contract of a GET call
  # response_contract : Response contract that will be compared with the expected contract for Ideas API
  def verifyIdeasResponseContract
    return verifyResponseContract(@ideas_response_structure)
  end

  # Method to verify the contract of a GET call
  # response_contract : Response contract that will be compared with the expected contract for Idea API
  def verifyIdeaResponseContract
    return verifyResponseContract(@idea_response_structure)
  end

  # Method to verify the contract of a GET call
  # response_contract : Response contract that will be compared with the expected contract for Post Idea API
  def verifyPostIdeaResponseContract
    return verifyResponseContract(@postIdea_response_structure)
  end

end