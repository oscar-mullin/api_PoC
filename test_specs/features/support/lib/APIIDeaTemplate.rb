module APIIdeaTemplate

  # Method to execute GET call through API framework and retrieve details of a specific Idea Template.
  # site_name  : Community title to retrieve its details
  def getIdeaTemplate(site_name)

    # Get the community ID
    community_id = getCommunityID(site_name)
    fail(ArgumentError.new("'#{site_name}' site was not found")) if community_id == ''

    url_base = "#{getURIBase}/api/v1/communities/#{community_id}/idea-template"

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

end