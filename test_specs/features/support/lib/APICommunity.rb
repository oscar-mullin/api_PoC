module APICommunity

  # Method to execute GET call through API framework and retrieve a list of all the communities where the current user has access.
  # header        : Parameters that will be added to URI's headers
  # params        : Parameters that will be added to URI's body
  def getCommunities(header, params)
    url_base = getURIBase + '/api/v1/communities'

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

  # Method to execute GET call through API framework and retrieve details of a specific community.
  # site_name  : Community title to retrieve its details
  def getCommunity(site_name)

    # Get the community ID
    community_id = getCommunityID(site_name)
    fail(ArgumentError.new("'#{site_name}' site was not found")) if community_id == ''

    url_base = "#{getURIBase}/api/v1/communities/#{community_id}"

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

  # Method to retrieve ID of a specific Community
  # site  : Title of the community to retrieve its ID
  def getCommunityID(site_name)
    community_id = ''
    community_found = false
    no_next_link = false

    offset = 0

    until community_found or no_next_link
      communities_response = getCommunities('', "offset:#{offset.to_s},limit:100")
      JSON.parse(communities_response)['links'].each do |navigation_link|
        if navigation_link['rel'] == 'next'
          no_next_link = false
          break
        else
          no_next_link = true
        end
      end
      response_content = JSON.parse(communities_response.body)['content']
      response_content.each do |content_element|
        if content_element['title'].include? ("#{site_name}")
          community_found = true
          community_id = content_element['id']
          break
        end
      end
      offset += 100
    end
    return community_id
  end

end