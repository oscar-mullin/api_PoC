class IdeaTemplateAPI

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

end