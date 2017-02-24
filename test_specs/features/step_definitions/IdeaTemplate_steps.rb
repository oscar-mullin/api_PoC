Given(/^I get the Idea Template of "([^"]*)" community$/) do |site_name|
  communityAPI = CommunityAPI.new

  # Get response for the Rest API Call and print it raw
  ideaTemplateAPI = IdeaTemplateAPI.new
  response = ideaTemplateAPI.getIdeaTemplate(communityAPI.getCommunityID)
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

And(/^I verify Idea Template Response structure is the expected$/) do
  idea_template_api = IdeaTemplateAPI.new(nil)

  response_expected_message = idea_template_api.verifyIdeaTemplateResponseContract
  fail(ArgumentError.new("Error in Response Contract expected\n#{response_expected_message}")) unless response_expected_message == ''
end