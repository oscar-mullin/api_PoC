class IdeaTemplateAPI

  def initialize(authentication_required, role_user)
    @apiUtil = APIUtil.new(authentication_required,role_user)
  end

  # Method to retrieve Idea Template of a specific community.
  # site_name  : Community title to retrieve its idea template
  def getIdeaTemplate(site_name)
    communityAPI = CommunityAPI.new(false,nil)
    community_id = communityAPI.getCommunityID(site_name)
    url_base = @apiUtil.getURIBase + "/api/v1/communities/#{community_id}/idea-template"
    response = @apiUtil.makeGetCall(url_base, nil, nil)
    return response
  end

end