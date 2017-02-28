class AuthenticationHelper

  @@tokens = nil
  def initialize
    @@tokens = Hash.new
  end

  def existsToken(user_role,username)

    if(!user_role.nil?)
      tokenElement = @@tokens[user_role]
      if(tokenElement.nil? or tokenElement.getUserRole != user_role)
        return false
      else
        return true
      end

    else if(!username.nil?)
           tokenElement = @@tokens[username]
           if(tokenElement.nil? or tokenElement.getUsername != username)
             return false
           else
             return true
           end
         end
    end
    return false
  end

  def getTokenElement(user_role,username)
    if(existsToken(user_role,username))
      if(!user_role.nil?)
        return @@tokens[user_role]
      else
        return @@tokens[username]
      end
    end
  end

  def setToken(user_role,username,token)
    if(!user_role.nil?)
      tokenElement = Token.new(user_role,nil,nil)
      tokenElement.setToken(token);
      @@tokens[user_role] = tokenElement
    else if(!username.nil?)
           tokenElement = Token.new(nil,username)
           tokenElement.setToken(token);
           @@tokens[username] = tokenElement
         end
    end
  end

  def getToken(user_role,username)
    tokenElement = getTokenElement(user_role,username)
    return tokenElement.getToken
  end

  def isTokenExpired(user_role,username)
    tokenElement = getTokenElement(user_role,username)
    return tokenElement.isTokenExpired
  end



end