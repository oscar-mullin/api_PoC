class ResponseUtil

  @code = nil
  @body = nil

  def setResponse(response)
    @code = response.code
    @body = response.body
  end

  def getData(data)
    if data == 'code'
      @code
    elsif data == 'body'
      @body
    end
  end

end