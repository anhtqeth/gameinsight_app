module GamesApiModule
  
  GAME_URI = "https://api-v3.igdb.com/games/"
  COVER_URI = 'https://api-v3.igdb.com/covers'
  ART_URI = 'https://api-v3.igdb.com/artworks'
  SCREENSHOTS_URI = 'https://api-v3.igdb.com/screenshots'
  RELEASE_URI = "https://api-v3.igdb.com/release_dates/"
  
  GAME_SEARCH_URI = "https://api-v3.igdb.com/search"
  GAME_COLLECTION_URI = "https://api-v3.igdb.com/collections"
  
  USERKEY = 'ada77f859e3e4c235b5b6e360c79e249'
  UNIX_TIME_NOW = Time.current.to_time.to_i
  
#NEED TO CATCH HTTP RESPONSE CODE BEFORE PROCEEDING!
#REFACTORING THE STRUCTURE OF CODE FOR REQUEST
  def gamesRequest(gameID)
    url = URI(GAME_URI)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(url)
    request["user-key"] = USERKEY
    
    request.body = "fields summary; where id = #{gameID};";
    #puts request.body

    response = http.request(request)
    # JSON.parse(response.read_body)
    JSON.parse(response.read_body)
  end
  
  def releaseDateRequest
    url = URI(RELEASE_URI)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    
    request = Net::HTTP::Get.new(url)
    request["user-key"] = USERKEY
    #request.body = "fields *; where game = #{gamesRequest.first['id']} & date > #{UNIX_TIME_NOW} & platform = 48;"
    request.body = "fields *; where game = #{gamesRequest.first['id']} & platform = 48;"
    response = http.request(request)
    
    result = JSON.parse(response.read_body)  
    puts result
    releaseTime = result.first['date']
    DateTime.strptime(releaseTime.to_s,'%s').strftime("%A-%d-%m-%Y")
  end
      
def gameCoverRequest(gameID)
    url = URI(COVER_URI)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    
    request = Net::HTTP::Get.new(url)
    request["user-key"] = USERKEY
    request.body = "fields *; where game = (#{gameID});"
    response = http.request(request)
    
    if JSON.parse(response.read_body).empty?
       ' '
      else
        result = JSON.parse(response.read_body)
        #puts result
        result.first['url'].sub! 't_thumb','t_cover_big'
    end
end
    # if result.nil?
    #     
    #   else
    #     result = JSON.parse(response.read_body)
    #     puts result
    #     result.first['url'].sub! 't_thumb','t_cover_big'
    # end
  def genericGameRequest
    
  end
  
  def gamesSearchRequest
    url = URI(GAME_SEARCH_URI)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(url)
    request["user-key"] = USERKEY
    request.body = 'fields *; where name = "Yakuza";'
    response = http.request(request)
    #puts JSON.parse(response.read_body)
    JSON.parse(response.read_body)
  end
  
  def gamesSeriesRequest
    require 'net/https'
    http = Net::HTTP.new('api-v3.igdb.com', 80)
    request = Net::HTTP::Get.new(URI(GAME_COLLECTION_URI), {'user-key' => USERKEY})
    request.body = "fields *; where id = (#{gamesSearchRequest.first['collection']});"
    #puts JSON.parse(http.request(request).read_body)
    JSON.parse(http.request(request).read_body)
  end
  
  def gamesListProcess 
    games_id_array = gamesSeriesRequest.first['games']
    #DEBUG Showing on Consoles
    #games_id_array.each {|x| puts x}
    #@game_summary = Array.new()
    #@game_cover = Array.new()
    @game_summary = games_id_array.map {|x|gamesRequest(x)}
    @game_cover = games_id_array.map {|x| gameCoverRequest(x)}
    
    [@game_summary,@game_cover]
  end
  
#   require 'net/https'
# http = Net::HTTP.new('api-v3.igdb.com', 80)
# request = Net::HTTP::Get.new(URI('https://api-v3.igdb.com/achievements'), {'user-key' => YOUR_KEY})
# request.body = 'fields achievement_icon,category,created_at,description,external_id,game,language,name,owners,owners_percentage,rank,slug,tags,updated_at;'
# puts http.request(request).body

end