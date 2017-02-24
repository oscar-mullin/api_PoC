class APIUtil

  URI_BASE = ENV['URI_BASE']
  GRANT_TYPE = 'password'
  # CODE = '8atTBIOh'

  # These elements can be set from UI web engage
  CLIENT_ID = 'MB4N5QCM1mC5'
  CLIENT_SECRET = 'MmS2cuWjEnNgHcYSWxkDES5xznDsDQeLqDBIUyOFqZEGz4KT'

  @username = ''
  @password = ''
  @@token = ''
  @@current_role = 'member'
  @@response = nil

  # role_user : Specify the role to select the credentials required to execute the API calls, roles available: 'superadmin', 'admin', 'member'
  def initialize(role_user='member')
    puts "Current role: '#{@@current_role}'\nNew role: '#{role_user}'\nToken: '#{@@token}'"

    if @@token == '' or (@@current_role != role_user and not(role_user.nil?))
      @@current_role = role_user unless role_user.nil? or role_user == ''
      case @@current_role
        when 'superadmin' then
          @username = ENV['API_USERNAME_SUPERADMIN']
          @password = ENV['API_PASSWORD_SUPERADMIN']

        when 'admin' then
          @username = ENV['API_USERNAME_ADMIN']
          @password = ENV['API_PASSWORD_ADMIN']

        when 'member' then
          @username = ENV['API_USERNAME_MEMBER']
          @password = ENV['API_PASSWORD_MEMBER']

        when 'none' then
          @@token = '_'
          return

        else
          fail(ArgumentError.new("'#{role_user}' role is not defined, current roles are:\nsuperadmin\nadmin\nmember\n"))
      end

      # Retrieve token
      createToken
    else
      puts "TOKEN WAS NOT CREATED, USING ROLE: '#{@@current_role}'"
    end
  end

  def makeGetCall(url, header, params)
    headers = Hash.new
    headers['Authorization'] = "Bearer #{getToken}"

    unless header.nil? or header == ''
      headers = headers.merge(__parseStringToHash__(header))
    end

    # if no params were sent then no need to add an empty hash
    unless params.nil? or params == ''
      headers['params'] = __parseStringToHash__(params)
    end

    begin
      @@response = RestClient.get(url, headers)
    rescue RestClient::Unauthorized
      createToken
      headers['Authorization'] = "Bearer #{getToken}"
      begin
        @@response = RestClient.get(url, headers)
      rescue => err
        @@response = err.response
      end
    rescue => err
      @@response = err.response
    end
  end

  def makePostCall(url, header, params)
    headers = Hash.new
    headers['Authorization'] = "Bearer #{getToken}"

    unless header.nil? or header == ''
      headers = headers.merge(header)
    end

    begin
      $responsePost = RestClient.post(url, params.to_json, headers)
    rescue RestClient::Unauthorized
      createToken
      $responsePost = RestClient.post(url, params.to_json, headers)
      return $responsePost
    rescue RestClient::Forbidden,RestClient::BadRequest => err
      return err.response
    else
      return $responsePost
    end
  end

  def createToken
    puts "CREATING TOKEN WITH ROLE: '#{@@current_role}'..."
    body = Hash.new

    body['grant_type'] = GRANT_TYPE
    body['client_id'] = CLIENT_ID
    body['client_secret'] = CLIENT_SECRET
    body['username'] = @username
    body['password'] = @password

    begin
      response = RestClient.post("#{URI_BASE}/oauth/token",body)
    rescue RestClient::Unauthorized, RestClient::Forbidden => err
      return err.response
    else
      @@token = JSON.parse(response)['access_token']
      return response
    end
  end

  # Method to retrieve the current token
  def getToken
    @@token
  end

  # Method to retrieve the URI base
  def getURIBase
    URI_BASE
  end

  # Method to retrieve response data
  def getResponse
    @@response
  end
  
  # Method to Parse a string given and parse it to Hash
  # string_to_parse : String to be parsed, format should be:
  # <key1>:<value1>,<key2>:<value2>,<...
  # e.g. foo1:bar1,foo2:bar2
  def __parseStringToHash__(string_to_parse)
    parameters = Hash.new
    string_to_parse.split(',').each do |pair|
      fail(ArgumentError.new("'#{string_to_parse}' string format is not correct\n"+
                              "The expected format should be:\n"+
                              "<key1>:<value1>,<key2>:<value2>,<...\n"+
                              "e.g. foo1:bar1,foo2:bar2\n")) if pair == '' or pair.nil?
      pairs = pair.split(':')

      fail(ArgumentError.new("'#{string_to_parse}' string format is not correct\n"+
                              "The expected format should be:\n"+
                              "<key1>:<value1>,<key2>:<value2>,<...\n"+
                              "e.g. foo1:bar1,foo2:bar2\n")) if pairs[0].nil? or pairs[1].nil? or pairs[0] == '' or pairs[1] == ''

      parameters[pairs[0]] = pairs[1].include?('{') ? __parseStringToHash__(pairs[1]) : pairs[1]
    end
    return parameters
  end

end