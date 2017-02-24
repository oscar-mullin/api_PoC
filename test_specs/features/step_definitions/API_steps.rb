require_relative '../support/API_Objects/community_api'
Given(/^I get all the communities with "([^"]*)" parameters$/) do |params|
  # Get response for the Rest API Call and print it raw
  communityAPI = CommunityAPI.new
  communityAPI.getAllCommunities(params)
end

Given(/^I post an idea on "([^"]*)" community with Title: "([^"]*)", Category: "([^"]*)", Tags: "([^"]*)" and "([^"]*)" parameters$/) do |site_name, idea_title, category_title, tags, params|
  # Get Community ID
  communityAPI = CommunityAPI.new
  community_id = communityAPI.getCommunityID

  # Get Category ID
  categoryAPI = CategoryApi.new
  category_id = categoryAPI.getCategoryID(community_id, category_title)

  # Get response for the Rest API Call and print it raw
  ideaAPI = IdeaAPI.new
  #TODO - Fix me when Post Idea has been defined
  #response = ideaAPI.postIdea(community_id, idea_title, category_id, tags, params)
  puts "\n\nRAW POST CALL RESPONSE: #{response}\n\n"

  # Verify that Code Response expected is 200
  unless response.code == 201
    fail(ArgumentError.new("An error has occurred.\n"+
                           "Response code: #{response.code}\n"+
                           "#{JSON.parse(response)['dev_message']}. #{JSON.parse(response)['message']}"))
  end

  # Print idea's title from body content
  response_content = JSON.parse(response)
  puts "IDEA TITLE LISTED: #{response_content['title']}\n"
end

Given(/^I get the details of "([^"]*)" community$/) do |site_name|
  # Get Community ID
  communityAPI = CommunityAPI.new
  community_id = communityAPI.getCommunityID
  communityAPI.getCommunity community_id
end

Given(/^I get the details of "([^"]*)" idea on "([^"]*)" community$/) do |idea_title,site_name|
  # Get Community ID
  communityAPI = CommunityAPI.new
  community_id = communityAPI.getCommunityID

  # Get response for the Rest API Call and print it raw
  ideasAPI = IdeasAPI.new
  ideaAPI = IdeaAPI.new
  idea_id = ideasAPI.getIdeaID(community_id,idea_title)
  response = ideaAPI.getIdea(idea_id )
  puts "\n\nRAW GET CALL RESPONSE: #{response}\n\n"

  # Verify that Code Response expected is 200
  unless response.code == 200
    fail(ArgumentError.new("An error has occurred.\n"+
                           "Response code: #{response.code}\n"+
                           "#{JSON.parse(response)['dev_message']}. #{JSON.parse(response)['message']}"))
  end

  # Print idea title from body content
  response_content = JSON.parse(response.body)
  puts "IDEA TITLE LISTED: #{response_content['title']}\n"
end
