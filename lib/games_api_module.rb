module GamesApiModule
  GAME_URI = "https://api-v3.igdb.com/games/"
  COVER_URI = 'https://api-v3.igdb.com/covers'
  ART_URI = 'https://api-v3.igdb.com/artworks'
  SCREENSHOTS_URI = 'https://api-v3.igdb.com/screenshots'
  RELEASE_URI = "https://api-v3.igdb.com/release_dates/"
  USERKEY = 'ada77f859e3e4c235b5b6e360c79e249'
  UNIX_TIME_NOW = Time.current.to_time.to_i
  
#NEED TO CATCH HTTP RESPONSE CODE BEFORE PROCEEDING!
#REFACTORING THE STRUCTURE OF CODE FOR REQUEST API
  def gamesRequest
    url = URI(GAME_URI)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(url)
    request["user-key"] = USERKEY
    request.body = 'fields *; where name = "Yakuza" & platform = 48;'
    response = http.request(request)
    JSON.parse(response.read_body)
  end
  
  #Fix #4  
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
      
  def gameDetails
        
  end
      
  def gameCoverRequest
    url = URI(COVER_URI)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    
    request = Net::HTTP::Get.new(url)
    request["user-key"] = USERKEY
    request.body = "fields *; where game = (#{gamesRequest.first['id']});"
    response = http.request(request)
    result = JSON.parse(response.read_body)
    #puts result
    url = result.first['url'].sub! 't_thumb','t_cover_big'
    #puts url
  end
  
#   require 'net/https'
# http = Net::HTTP.new('api-v3.igdb.com', 80)
# request = Net::HTTP::Get.new(URI('https://api-v3.igdb.com/achievements'), {'user-key' => YOUR_KEY})
# request.body = 'fields achievement_icon,category,created_at,description,external_id,game,language,name,owners,owners_percentage,rank,slug,tags,updated_at;'
# puts http.request(request).body

end