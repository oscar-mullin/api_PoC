class APIUtil

  URI_BASE = ENV['URI_BASE']
  GRANT_TYPE = 'password'
  # CODE = '8atTBIOh'
  CLIENT_ID = 'MB4N5QCM1mC5'
  CLIENT_SECRET = 'MmS2cuWjEnNgHcYSWxkDES5xznDsDQeLqDBIUyOFqZEGz4KT'

  @@current_role = ''
  @@token = ''
  @@response = nil
  @@authenticationHelper = nil

  @username = ''
  @password = ''
  @executor = nil
  @requiresAuthentication = true

  # role_user : Specify the role to select the credentials required to execute the API calls, roles available: 'superadmin', 'admin', 'member'
  def initialize(role_user='member',requiresAuthentication=true,username='',password='')
    if(@@authenticationHelper.nil?)
      @@authenticationHelper = AuthenticationHelper.new
    end
    @executor = APIClientWrapper.new
    @requiresAuthentication = requiresAuthentication
    if(@requiresAuthentication and getUser(role_user,username,password))
      obtainToken(role_user,username)
    end
  end

  def obtainToken(role_user,username='')
    if(@@authenticationHelper.nil? or !@@authenticationHelper.existsToken(role_user,username) or @@authenticationHelper.isTokenExpired(role_user,username))
      puts "Creating token for #{role_user}"
      createToken
      @@authenticationHelper.setToken(role_user,username,getToken)
      return getToken
    else
      puts "Getting token for #{role_user}"
      @@token = @@authenticationHelper.getToken(role_user,username)
      return @@token
    end
  end

  def isAValidRole(role_user)
    validRoles = ["SUPERADMIN","ADMIN","MEMBER","NONE"]
    if(!validRoles.include? role_user)
      fail(ArgumentError.new("'#{role_user}' role is not defined, current roles are:\nsuperadmin\nadmin\nmember\n"))
    end
  end

  def getDefaultUserFromRoleAndDefineNeedForToken(role_user)
    if(role_user.nil? or role_user.upcase == "NONE")
      return false
    end
    isAValidRole(role_user.upcase)
    @@current_role = role_user.upcase
    userPrefix = "API_USERNAME_"
    passPrefix = "API_PASSWORD_"
    @username = ENV[userPrefix+@@current_role]
    @password = ENV[passPrefix+@@current_role]
        return true;
  end


  def getUser(role_user='member',username='',password='')
    if(username == '' and password == '')
      getDefaultUserFromRoleAndDefineNeedForToken(role_user)
    else
      setUserFromUsernameAndPassword(username,password)
    end
  end


  def setUserFromUsernameAndPassword(username,password)
    @username = username
    @password = password
  end


  def makeGetCall(url,header, params)
    @@response = ResponseWrapper.new
    begin
      @executor.get(url,header,params,@requiresAuthentication,getToken)
      @@response.body = @executor.response.body
      @@response.code = @executor.response.code
    rescue => err
      @@response = err.response
    end
  end

  def makePostCall(url, header, params)
    @@response = ResponseWrapper.new
    begin
      @executor.post(url,header,params,@requiresAuthentication,getToken)
      @@response.body = @executor.response.body
      @@response.code = @executor.response.code
    rescue => err
      @@response = err.response
    end
  end

  def createToken
    @@response = ResponseWrapper.new
    body = Hash.new
    body['grant_type'] = GRANT_TYPE
    body['client_id'] = CLIENT_ID
    body['client_secret'] = CLIENT_SECRET
    body['username'] = @username
    body['password'] = @password
    @executor.token("#{getURIBase}/oauth/token",body)
    @@response.code = @executor.response.code
    @@response.body = @executor.response.body
    @@token = JSON.parse(@@response.body)['access_token']
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

  def getExecutor
    @executor
  end

  def verifyResponseContract(base_contract)
    final_message = ''
    response_content = JSON.parse(getResponse.body)
    if response_content.size == base_contract.size
      response_content.each do |key, _|
        unless base_contract.include?(key)
          final_message = "Element: #{key} was not expected, expected keys are: #{base_contract}"
          break
        end
      end
    else
      final_message = "Elements found: #{response_content.keys}\nElements expected: #{base_contract}"
    end
    return final_message
  end
end