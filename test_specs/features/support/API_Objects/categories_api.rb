class CategoriesApi
  RESPONSE_BODY_STRUCTURE = Array['total_count', 'links', 'content']

  def initialize(role_user=nil)
    @apiUtil = APIUtil.new(role_user)
  end

  # Method to retrieve all the categories of an specific community.
  # community_id  : Community ID to retrieve its categories
  # header        : Parameters that will be added to URI's headers
  # params        : Parameters that will be added to URI's body
  def getAllCategories(community_id, params)
    url_base = @apiUtil.getURIBase + "/api/v1/communities/#{community_id}/categories"
    response = @apiUtil.makeGetCall(url_base, nil, params)
    return response
  end

  # Method to retrieve the ID of a specific category of a specific community.
  # community_id   : Community ID where the category will be retrieved
  # category_title : Category's title
  def getCategoryID(community_id, category_title)
    category_id = ''
    category_found = false
    no_next_link = false
    offset = 0

    until category_found or no_next_link
      categories_response = getAllCategories(community_id, "offset:#{offset},limit:100")
      response_content = JSON.parse(categories_response.body)['content']
      category = response_content.select{|h1| h1['title'] == category_title}.first
      category_found = !(category.nil?)
      category_id = category['id'] if category_found
      no_next_link = !((JSON.parse(categories_response.body)['links'].select{|h1| h1['rel'] == 'next'}).nil?)
      offset += 100 unless no_next_link
    end

    return category_id
  end

  # Method to verify the contract of a GET call
  # response_contract : Response contract that will be compared with the expected contract for Categories API
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