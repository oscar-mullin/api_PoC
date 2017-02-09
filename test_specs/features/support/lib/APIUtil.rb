class APIUtil

  URI_BASE = 'https://qabuilds.spigit.com'
  GRANT_TYPE = 'password'
  # CODE = '8atTBIOh'
  CLIENT_ID = 'MB4N5QCM1mC5'
  CLIENT_SECRET = 'MmS2cuWjEnNgHcYSWxkDES5xznDsDQeLqDBIUyOFqZEGz4KT'

  @@username = 'admin'
  @@password = 'farmtotable123'
  @@token = ''

  def _setToken(token_value)
    @@token = token_value
  end

  def _getToken
    @@token
  end

  def _getUsername()
    @@username
  end

  def _setUsername(new_username)
    @@username = new_username
  end

  def _getPassword()
    @@password
  end

  def _setPassword(new_password)
    @@password = new_password
  end

  def getTokens
    body = Hash.new

    body['grant_type'] = GRANT_TYPE
    body['client_id'] = CLIENT_ID
    body['client_secret'] = CLIENT_SECRET
    body['@@username'] = _getUsername
    body['@@password'] = _getPassword

    begin
      response = RestClient.post("#{URI_BASE}/oauth/token",body)
    rescue RestClient::Unauthorized, RestClient::Forbidden => err
      return err.response
    else
      _setToken(JSON.parse(response)['access_token'])
      return response
    end

  end

  # TODO If executeGET is going to be a generic method then there should be another method to prepare the url according to what we want to get
  # def executeGet(url, params, authentication_required, username, password)
  #
  #   # Get access token
  #   if authentication_required
  #     _setUsername username
  #     _setPassword password
  #     response = getTokens
  #     unless response.code == 200
  #       fail(ArgumentError.new("An error has occurred.\n#{JSON.parse(response)['dev_message']}. #{JSON.parse(response)['message']}"))
  #     end
  #   end
  #
  #   headers = Hash.new
  #
  #   headers['Authorization'] = "Bearer #{_getToken}"
  #
  #   # if no params were sent then no need to add an empty hash
  #   unless params.nil? or params == ''
  #     parameters = Hash.new
  #     params.split(',').each do |pair|
  #       pairs = pair.split(':')
  #       parameters = {pairs[0] => pairs[1]}
  #     end
  #     headers['params'] = parameters
  #   end
  #
  # TODO Here is where it should manage the url in order to understand what we want to get
  #   begin
  #     response = RestClient.get(url, headers)
  #   rescue RestClient::Unauthorized, RestClient::Forbidden => err
  #     return err.response
  #   else
  #     return response
  #   end
  # end

  def getCommunitiesWithParameters(params)
    headers = Hash.new

    headers['Authorization'] = "Bearer #{@@token}"

    # if no params were sent then no need to add an empty hash
    unless params.nil? or params == ''
      parameters = Hash.new
      params.split(',').each do |pair|
        pairs = pair.split(':')
        parameters = {pairs[0] => pairs[1]}
      end
      headers['params'] = parameters
    end

    begin
      response = RestClient.get("#{URI_BASE}/api/v1/communities", headers)
    rescue RestClient::Unauthorized, RestClient::Forbidden => err
      return err.response
    else
      return response
    end
  end







  def initialize
    @restAPIResponse = nil
  end

  def getResponse
    @restAPIResponse
  end

  def setResponse(response)
    @restAPIResponse = response
  end

  def getResponseParamFromHeader(param)
    getResponse.headers[param]
  end

  def executeGETCommand(url, header)
    if header == ''
      RestClient.get url
    else
      parameters = Hash.new
      header.split(',').each do |pair|
        pairs = pair.split(':')
        parameters = {pairs[0] => pairs[1]}
      end
      setResponse RestClient.get url, parameters
    end
  end

  def executePOSTCommand(url, header, body)
    if header == ''
      RestClient.post url, body
    else
      headers = Hash.new
      header.split(',').each do |pair|
        pairs = pair.split(':')
        headers = {pairs[0] => pairs[1]}
      end
      parameters = Hash.new
      body.split(',').each do |pair|
        pairs = pair.split(':')
        parameters = {pairs[0] => pairs[1]}
      end
      @restAPIResponse = RestClient.post url, headers, parameters
    end
  end



end