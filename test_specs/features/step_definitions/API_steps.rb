require_relative '../support/API_Objects/community_api'
Given(/^I get all the communities with "([^"]*)" parameters$/) do |params|
  # Get response for the Rest API Call and print it raw
  #response = @apiutil.getCommunities('', params)
  communityAPI = CommunityAPI.new(true,'superadmin')

  #Example of how to call the get community
  getCommunityResponse = communityAPI.getCommunity "QAArComm1"

  #Example of how to get all communities
  response = communityAPI.getAllCommunities(params)

  # Verify that Code Response expected is 200
  unless response.code == 200
    fail(ArgumentError.new("An error has occurred.\nResponse code: #{response.code}\n#{JSON.parse(response)['dev_message']}. #{JSON.parse(response)['message']}"))
  end

  # Print communities' title from body content
  response_content = JSON.parse(response.body)['content']
  puts "RAW GET CALL RESPONSE CONTENT: #{response_content}\n"
  response_content.each do |content_element|
    puts "COMMUNITY TITLE LISTED: #{content_element['title']}\n"
  end
end


Given(/^I post an idea on "([^"]*)" community with "([^"]*)" parameters in "([^"]*)" format$/) do |site, params, format|
  # Get response for the Rest API Call and print it raw
  response = @apiutil.executePost('post_idea',format, params)
  puts "RAW GET CALL RESPONSE: #{response}\n\n"

  # Verify that Code Response expected is 200
  unless response.code == 200
    fail(ArgumentError.new("An error has occurred.\nResponse code: #{response.code}\n#{JSON.parse(response)['dev_message']}. #{JSON.parse(response)['message']}"))
  end

  # Print idea's title from body content
  response_content = JSON.parse(response.body)['content']
  puts "RAW GET CALL RESPONSE CONTENT: #{response_content}\n"
  response_content.each do |content_element|
    puts "IDEA TITLE LISTED: #{content_element['title']}\n"
  end
end
