module APIIdea

  # Method to execute GET call through API framework and retrieve a list of all the ideas on a specific community.
  # site_name  : Community title to retrieve its categories
  # header    : Parameters that will be added to URI's headers
  # params    : Parameters that will be added to URI's body
  def getIdeas(site_name, header, params)

    # Get the community ID
    community_id = getCommunityID(site_name)
    fail(ArgumentError.new("'#{site_name}' site was not found")) if community_id == ''

    url_base = "#{getURIBase}/api/v1/communities/#{community_id}/ideas"

    if getToken == ''
      # Get access token
      response = createToken
      unless response.code == 200
        fail(ArgumentError.new("An error has occurred.\n#{JSON.parse(response)['dev_message']}. #{JSON.parse(response)['message']}"))
      end
    else
      puts 'NEW TOKEN WAS NOT CREATED'
    end

    headers = Hash.new
    headers['Authorization'] = "Bearer #{getToken}"

    # if no other headers were sent then no need to add an empty hash
    unless header.nil? or header == ''
      headers = headers.merge(__parseStringToHash__(header))
    end

    # if no params were sent then no need to add an empty hash
    unless params.nil? or params == ''
      headers['params'] = __parseStringToHash__(params)
    end

    begin
      response = RestClient.get(url_base, headers)
    rescue RestClient::Unauthorized
      createToken
      response = RestClient.get(url_base, headers)
      return response
    rescue RestClient::Forbidden => err
      return err.response
    else
      return response
    end
  end

  # Method to execute GET call through API framework and retrieve details of a specific idea.
  # idea_title  : Community title to retrieve its details
  def getIdea(site_name, idea_title)

    # Get the community ID
    idea_id = getIdeaID(site_name, idea_title)
    fail(ArgumentError.new("'#{idea_title}' site was not found")) if idea_id == ''

    url_base = "#{getURIBase}/api/v1/ideas/#{idea_id}"

    if getToken == ''
      # Get access token
      response = createToken
      unless response.code == 200
        fail(ArgumentError.new("An error has occurred.\n#{JSON.parse(response)['dev_message']}. #{JSON.parse(response)['message']}"))
      end
    else
      puts 'NEW TOKEN WAS NOT CREATED'
    end

    headers = Hash.new
    headers['Authorization'] = "Bearer #{getToken}"

    begin
      response = RestClient.get(url_base, headers)
    rescue RestClient::Unauthorized
      createToken
      response = RestClient.get(url_base, headers)
      return response
    rescue RestClient::Forbidden => err
      return err.response
    else
      return response
    end
  end

  # Method to retrieve ID of a specific idea
  # idea_title  : Title of the idea to retrieve its ID
  def getIdeaID(site_name, idea_title)
    idea_id = ''
    idea_found = false
    no_next_link = false

    offset = 0

    until idea_found or no_next_link
      ideas_response = getIdeas(site_name, '', "offset:#{offset.to_s},limit:100")
      JSON.parse(ideas_response)['links'].each do |navigation_link|
        if navigation_link['rel'] == 'next'
          no_next_link = false
          break
        else
          no_next_link = true
        end
      end
      response_content = JSON.parse(ideas_response.body)['content']
      response_content.each do |content_element|
        if content_element['title'].include? ("#{idea_title}")
          idea_found = true
          idea_id = content_element['id']
          break
        end
      end
      offset += 100
    end
    return idea_id
  end

  # Method to execute POST call through API framework to post an idea to a specific community
  # site            : Community's title where the idea will be posted
  # idea_title      : Title for the idea to be posted
  # category_title  : Category's title where the idea will be posted
  # tags            : Tags for the idea
  # header          : Parameters that will be added to URI's headers
  # params          : Parameters that will be added to URI's body
  def postIdea(site_name, idea_title, category_title, tags, header, params)

    # Get the community ID
    community_id = getCommunityID(site_name)
    fail(ArgumentError.new("'#{site_name}' site was not found")) if community_id == ''

    url_base = "#{getURIBase}/api/v1/communities/#{community_id}/ideas"

    # Get Category ID
    category_id = getCategoryID(site_name, category_title)
    fail(ArgumentError.new("'#{category_title}' category was not found")) if category_id == ''

    if getToken == ''
      # Get access token
      response = createToken
      unless response.code == 200
        fail(ArgumentError.new("An error has occurred.\n#{JSON.parse(response)['dev_message']}. #{JSON.parse(response)['message']}"))
      end
    end

    headers = Hash.new
    headers['Authorization'] = "Bearer #{getToken}"
    headers['Content-Type'] = 'application/json'

    # if no other headers were sent then no need to add an empty hash
    unless header.nil? or header == ''
      headers = headers.merge(__parseStringToHash__(header))
    end

    parameters = Hash.new
    parameters['title'] = idea_title
    parameters['category_id'] = category_id.to_i
    parameters['tags'] = tags.nil? ? '' : tags

    # if no params were sent then no need to add an empty hash
    unless params.nil? or params == ''
      parameters['template_fields'] = __parseStringToHash__(params)
    end

    puts "HERE1: #{headers}\n"
    puts "HERE2: #{parameters}\n"
    puts "HERE3: #{url_base}"

    begin
      response = RestClient.post(url_base, parameters.to_json, headers)
    rescue RestClient::Unauthorized
      createToken
      response = RestClient.post(url_base, parameters.to_json, headers)
      return response
    rescue RestClient::Forbidden,RestClient::BadRequest => err
      return err.response
    else
      return response
    end
  end

end