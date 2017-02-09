And(/^I execute a GET command to "([^"]*)" URL$/) do |url|
  apiutil = APIUtil.new
  response = apiutil.executeGETCommand(url,'')
  puts response
end

Given(/^I execute a GET command to "([^"]*)" URL with "([^"]*)" header$/) do |url, header|
  apiutil = APIUtil.new
  response = apiutil.executeGETCommand(url,header)
  response_body_json = JSON.parse response.body
  puts "HERE: #{response.code}"
  puts "User ID: #{response_body_json['userId']}\n"
  puts "ID: #{response_body_json['id']}\n"
  puts "Title: #{response_body_json['title']}\n"
  puts "Body: #{response_body_json['body']}\n"
  puts "Headers: #{response.headers}"
  puts "Header Date: #{apiutil.getResponseParamFromHeader('date')}"
end

Given(/^I execute a POST command to "([^"]*)" URL with "([^"]*)" header and "([^"]*)" body$/) do |url, header, body|
  apiutil = APIUtil.new
  response = apiutil.executePOSTCommand(url,header,body)
  puts response
end

Given(/^I get tokens$/) do
  # Instance the API Resources file
  apiutil = APIUtil.new

  # Get response for the Rest API Call and print it raw
  response = apiutil.getTokens
  puts "RAW GET CALL RESPONSE: #{response}\n\n"

  # Verify that Code Response expected is 200
  unless response.code == 200
    fail(ArgumentError.new("An error has occurred.\n#{JSON.parse(response)['dev_message']}. #{JSON.parse(response)['message']}"))
  end

  # Print body content per elements
  puts "access_token:#{JSON.parse(response)['access_token']}\n"
  puts "token_type:#{JSON.parse(response)['token_type']}\n"
  puts "issued_at:#{JSON.parse(response)['issued_at']}\n"
  puts "expires_in:#{JSON.parse(response)['expires_in']}\n"

end

Given(/^I get all the communities with "([^"]*)" parameters$/) do |params|
  # Instance the API Resources file
  apiutil = APIUtil.new

  # Get response for the Rest API Call and print it raw
  response = apiutil.getCommunitiesWithParameters(params)
  puts "RAW GET CALL RESPONSE: #{response}\n\n"

  # Verify that Code Response expected is 200
  unless response.code == 200
    fail(ArgumentError.new("An error has occurred.\n#{JSON.parse(response)['dev_message']}. #{JSON.parse(response)['message']}"))
  end

  # Print communities' title from body content
  response_content = JSON.parse(response.body)['content']
  puts "RAW GET CALL RESPONSE CONTENT: #{response_content}\n"
  response_content.each do |content_element|
    puts "COMMUNITY TITLE LISTED: #{content_element['title']}\n"
  end
end
