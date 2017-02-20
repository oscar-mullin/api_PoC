class CategoryAPI

  def initialize(authentication_required, role_user)
    @apiUtil = APIUtil.new(authentication_required,role_user)
  end

  # Method to retrieve all the categories of an specific community.
  # site_name  : Community title to retrieve its categories
  # header    : Parameters that will be added to URI's headers
  # params    : Parameters that will be added to URI's body
  def getAllCategories(site_name, params)
    communityAPI = CommunityAPI.new(false,nil)
    community_id = communityAPI.getCommunityID(site_name)
    url_base = @apiUtil.getURIBase + "/api/v1/communities/#{community_id}/categories"
    response = @apiUtil.makeGetCall(url_base, nil, params)
    return response
  end

  # Method to retrieve the ID of a specific category of a specific community.
  # site_name     : Community title where the category will be retrieved
  # category_title : Category's title
  def getCategoryID(site_name, category_title)
    category_id = ''
    category_found = false
    no_next_link = false
    offset = 0

    until category_found or no_next_link
      categories_response = getAllCategories(site_name, "offset:#{offset},limit:100")
      response_content = JSON.parse(categories_response.body)['content']
      category = response_content.select{|h1| h1['title'] == category_title}.first
      category_found = !(category.nil?)
      category_id = category['id'] if category_found
      no_next_link = !((JSON.parse(categories_response.body)['links'].select{|h1| h1['rel'] == 'next'}).nil?)
      offset += 100 unless no_next_link
    end

    return category_id
  end

end