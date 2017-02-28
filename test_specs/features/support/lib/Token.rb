
class Token
  @user_role
  @username
  @password
  @token
  @setTime
  @expireTime
  TOKEN_TTL_MINUTES = 60

  def initialize(user_role,username,password)
    @user_role = user_role
    @username = username
  end

  def getUserRole
    @user_role
  end

  def getUsername
    @username
  end

  def setToken(token)
    @token = token
    @setTime = Time.now
    @expireTime = @setTime + (TOKEN_TTL_MINUTES * 60)
  end

  def getToken
    @token
  end

  def isTokenExpired
    if(Time.now < @expireTime)
      return false
    end
    return true
  end

end