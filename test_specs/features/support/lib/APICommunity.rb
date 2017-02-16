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
    rescue RestClient::Forbidden => err
      return err.response
    else
      return response
    end
  end

  # TODO: under construction
  # Method to execute GET call through API framework and retrieve details of an specific community.
  # sitename  : Community title to retrieve its details
  # header    : Parameters that will be added to URI's headers
  # params    : Parameters that will be added to URI's body
  def getCommunity(sitename)
    url_base = getURIBase + '/api/v1/communities'
    community_id = ''
    # I get the community ID
    community_found = false
    until community_found
      communities_response = getCommunities('', 'limit:100')
      response_content = JSON.parse(communities_response.body)['content']
      response_content.each do |content_element|
        if content_element['title'].include? ("#{sitename}")
          community_found = true
          community_id = content_element['id']
          break
        end
      end
      list_end_reached = true if community_found
    end

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
    rescue RestClient::Forbidden => err
      return err.response
    else
      return response
    end
  end

end