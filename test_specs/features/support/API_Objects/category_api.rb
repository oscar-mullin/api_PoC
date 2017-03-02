require_relative '../../support/lib/APIUtil'
class CategoryAPI < APIUtil

  @@category_id = '_'

  def initialize(role_user=nil)
    super(role_user)
    @categories_response_structure = Array['total_count', 'links', 'content']
  end

  def getCategoryID
    @@category_id
  end

  # Method to retrieve all the categories of an specific community.
  # community_id  : Community ID to retrieve its categories
  # params        : Parameters that will be added to URI's body
  def getAllCategories(community_id, params)
    url_base = URI_BASE + "/api/v1/communities/#{community_id}/categories"
    makeGetCall(url_base, nil, params)
  end

  # Method to retrieve the ID of a specific category of a specific community.
  # community_id   : Community ID where the category will be retrieved
  # category_title : Category's title
  def findCategoryID(community_id, category_title)
    category_found = false
    no_next_link = false
    offset = 0
    @@category_id = '_'

    until category_found or no_next_link
      getAllCategories(community_id, "offset:#{offset},limit:100")
      response_content = JSON.parse(@@response.body)['content']
      category = response_content.select{|h1| h1['title'] == category_title}.first
      category_found = !(category.nil?)
      @@category_id = category['id'] if category_found
      no_next_link = !((JSON.parse(@@response.body)['links'].select{|h1| h1['rel'] == 'next'}).nil?)
      offset += 100 unless no_next_link
    end
  end

  # Method to verify the contract of a GET call for all Categories
  def verifyCategoriesResponseContract
    verifyResponseContract(@categories_response_structure)
  end

end