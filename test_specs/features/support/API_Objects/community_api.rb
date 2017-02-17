require_relative '../lib/APIUtil'
class CommunityAPI


  def initialize(authentication_required, role_user)
    @apiUtil = APIUtil.new(authentication_required,role_user)
  end

  def getAllCommunities(params)
    url_base = @apiUtil.getURIBase + '/api/v1/communities'
    response = @apiUtil.makeGetCall(url_base, nil, params)
  end

  def getCommunity(siteName)
      communities_response = getAllCommunities('limit:100')
      response_content = JSON.parse(communities_response.body)['content']
      community = response_content.select{|h1| h1['title']==siteName}.first
    puts "HERE: #{community}"
  end


end