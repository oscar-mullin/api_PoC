require_relative '../../support/lib/APIUtil'
class IdeaTemplateAPI < APIUtil

  def initialize(role_user=nil)
    super(role_user)
    @idea_template_response_structure = Array['acceptable_date_pattern', 'annonymous_allowed', 'post_idea_allowed', 'has_category', 'links', 'idea_template']
  end

  # Method to retrieve Idea Template of a specific community.
  # community_id  : Community ID to retrieve its idea template
  def getIdeaTemplate(makeGetCall)
    url_base = URI_BASE + "/api/v1/communities/#{community_id}/idea-template"
    response = makeGetCall(url_base, nil, nil)
    return response
  end

  # Method to verify the contract of a GET call for Idea Template
  def verifyIdeaTemplateResponseContract
     verifyResponseContract(@idea_template_response_structure)
  end

end