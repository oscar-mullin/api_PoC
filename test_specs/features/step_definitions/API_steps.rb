require_relative '../support/API_Objects/community_api'
Given(/^I get all the communities with "([^"]*)" parameters$/) do |params|
  # Get response for the Rest API Call and print it raw
  communityAPI = CommunityAPI.new
  response = communityAPI.getAllCommunities(params)
  puts "\n\nRAW GET CALL RESPONSE: #{response}\n\n"

  # Verify that Code Response expected is 200
  unless response.code == 200
    fail(ArgumentError.new("An error has occurred.\n"+
                           "Response code: #{response.code}\n"+
                           "#{JSON.parse(response)['dev_message']}. #{JSON.parse(response)['message']}"))
  end

  # Print communities' title from body content
  response_content = JSON.parse(response.body)['content']
  puts "RAW GET CALL RESPONSE CONTENT: #{response_content}\n"
  response_content.each do |content_element|
    puts "COMMUNITY TITLE LISTED: #{content_element['title']}\n"
  end
end

Given(/^I post an idea on "([^"]*)" community with Title: "([^"]*)", Category: "([^"]*)", Tags: "([^"]*)" and "([^"]*)" parameters$/) do |site_name, idea_title, category_title, tags, params|
  # Get Community ID
  communityAPI = CommunityAPI.new
  community_id = communityAPI.getCommunityID(site_name)

  # Get Category ID
  categoryAPI = CategoryAPI.new
  category_id = categoryAPI.getCategoryID(community_id, category_title)

  # Get response for the Rest API Call and print it raw
  ideaAPI = IdeaAPI.new
  response = ideaAPI.postIdea(community_id, idea_title, category_id, tags, params)
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

  communityAPI = CommunityAPI.new
  response = communityAPI.getCommunity site_name

  # Get response for the Rest API Call and print it raw
  puts "\n\nRAW GET CALL RESPONSE: #{response}\n\n"

  # Verify that Code Response expected is 200
  unless response.code == 200
    fail(ArgumentError.new("An error has occurred.\n"+
                           "Response code: #{response.code}\n"+
                           "#{JSON.parse(response)['dev_message']}. #{JSON.parse(response)['message']}"))
  end

  # Print community title from body content
  response_content = JSON.parse(response.body)
  puts "COMMUNITY TITLE LISTED: #{response_content['title']}\n"
end

Given(/^I get the categories of "([^"]*)" community with "([^"]*)" parameters$/) do |site_name, params|
  # Get Community ID
  communityAPI = CommunityAPI.new
  community_id = communityAPI.getCommunityID(site_name)

  # Get response for the Rest API Call and print it raw
  categoryAPI = CategoryAPI.new
  response = categoryAPI.getAllCategories(community_id,params)
  puts "\n\nRAW GET CALL RESPONSE: #{response}\n\n"

  # Verify that Code Response expected is 200
  unless response.code == 200
    fail(ArgumentError.new("An error has occurred.\n"+
                           "Response code: #{response.code}\n"+
                           "#{JSON.parse(response)['dev_message']}. #{JSON.parse(response)['message']}"))
  end

  # Print categories' title from body content
  response_content = JSON.parse(response.body)['content']
  puts "RAW GET CALL RESPONSE CONTENT: #{response_content}\n"
  response_content.each do |content_element|
    puts "CATEGORY TITLE LISTED: #{content_element['title']}\n"
  end
end

Given(/^I get the ideas of "([^"]*)" community with "([^"]*)" parameters$/) do |site_name, params|
  # Get Community ID
  communityAPI = CommunityAPI.new
  community_id = communityAPI.getCommunityID(site_name)

  # Get response for the Rest API Call and print it raw
  ideaAPI = IdeaAPI.new
  response = ideaAPI.getAllIdeas(community_id,params)
  puts "\n\nRAW GET CALL RESPONSE: #{response}\n\n"

  # Verify that Code Response expected is 200
  unless response.code == 200
    fail(ArgumentError.new("An error has occurred.\n"+
                           "Response code: #{response.code}\n"+
                           "#{JSON.parse(response)['dev_message']}. #{JSON.parse(response)['message']}"))
  end

  # Print ideas' title from body content
  response_content = JSON.parse(response.body)['content']
  puts "RAW GET CALL RESPONSE CONTENT: #{response_content}\n"
  response_content.each do |content_element|
    puts "IDEA TITLE LISTED: #{content_element['title']}\n"
  end
end

Given(/^I get the details of "([^"]*)" idea on "([^"]*)" community$/) do |idea_title,site_name|
  # Get Community ID
  communityAPI = CommunityAPI.new
  community_id = communityAPI.getCommunityID(site_name)

  # Get response for the Rest API Call and print it raw
  ideaAPI = IdeaAPI.new
  response = ideaAPI.getIdea(community_id,idea_title)
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

Given(/^I get the Idea Template of "([^"]*)" community$/) do |site_name|
  # Get Community ID
  communityAPI = CommunityAPI.new
  community_id = communityAPI.getCommunityID(site_name)

  # Get response for the Rest API Call and print it raw
  ideaTemplateAPI = IdeaTemplateAPI.new
  response = ideaTemplateAPI.getIdeaTemplate(community_id)
  puts "\n\nRAW GET CALL RESPONSE: #{response}\n\n"

  # Verify that Code Response expected is 200
  unless response.code == 200
    fail(ArgumentError.new("An error has occurred.\n"+
                           "Response code: #{response.code}\n"+
                           "#{JSON.parse(response)['dev_message']}. #{JSON.parse(response)['message']}"))
  end

  # Print communities' title from body content
  response_content = JSON.parse(response.body)['idea_template']
  puts "RAW GET CALL RESPONSE CONTENT: #{response_content}\n"
  puts "IDEA TEMPLATE FIELDS:\n"
  response_content['fields'].each do |field|
    puts "'#{field}'\n"
  end
end
