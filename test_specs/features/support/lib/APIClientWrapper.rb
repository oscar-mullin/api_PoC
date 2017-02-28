require 'excon'
class APIClientWrapper

  attr_accessor :response

  def initialize
    @response = ResponseWrapper.new
  end

  def get(url, header, params,requiresAuthorization=true, token='')
    headers = Hash.new
    setHeaders(headers,requiresAuthorization,token,header)
    setParams(headers,params)

# USING RESTCLIENT
    resp = RestClient.get(url, headers)
    @response.code = resp.code
    @response.body = resp.body
=begin
# USING EXCON INSTEAD OF REST CLIENT
    resp_ex = Excon.get(URI.encode(url),
              :headers => headers,
              :query => params
    )
    @response.body = resp_ex.body
    @response.code = resp_ex.status
=end
  end

  def post(url,header,params,requiresAuthorization=true,token='')
    headers = Hash.new
    setHeaders(headers,requiresAuthorization,token,header)
    resp = RestClient.post(url, params.to_json, headers)
    @response.code = resp.code
    @response.body = resp.body
  end

  def token(url,body)
    #USING RESTCLIENT
    resp =  RestClient.post(url,body)
    @response.code = resp.code
    @response.body = resp.body
=begin
    #USING EXCON
    resp_ex = Excon.post(url,
               :body => URI.encode_www_form(body),
               :headers => { "Content-Type" => "application/x-www-form-urlencoded" })
    @response.code = resp_ex.status
    @response.body = resp_ex.body
=end
  end

  def setHeaders(headersHash,requiresAuthorization=true,token,elementsToAdd)
    if(requiresAuthorization)
      headersHash['Authorization'] = "Bearer #{token}"
    end
    unless elementsToAdd.nil? or elementsToAdd == ''
      headersHash = headersHash.merge(__parseStringToHash__(elementsToAdd))
    end
  end

  def setParams(hash,elementsToAdd)
    # if no params were sent then no need to add an empty hash
    unless elementsToAdd.nil? or elementsToAdd == ''
      hash['params'] = __parseStringToHash__(elementsToAdd)
    end
  end

  # Method to Parse a string given and parse it to Hash
  # string_to_parse : String to be parsed, format should be:
  # <key1>:<value1>,<key2>:<value2>,<...
  # e.g. foo1:bar1,foo2:bar2
  def __parseStringToHash__(string_to_parse)
    errorMessage = "string format is not correct\n The expected format should be:\n <key1>:<value1>,<key2>:<value2>\n e.g. foo1:bar1,foo2:bar2\n"
    parameters = Hash.new
    string_to_parse.split(',').each do |pair|
      if pair == '' or pair.nil?
        fail(ArgumentError.new("'#{string_to_parse}' " + errorMessage))
      end
      pairs = pair.split(':')
      if pairs[0].nil? or pairs[1].nil? or pairs[0] == '' or pairs[1] == ''
        fail(ArgumentError.new("'#{string_to_parse}' " + errorMessage))
      end
      parameters[pairs[0]] = pairs[1].include?('{') ? __parseStringToHash__(pairs[1]) : pairs[1]
    end
    return parameters
  end


end