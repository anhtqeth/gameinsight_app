module GamesApiModule
  
  GAME_URI = "https://api-v3.igdb.com/games/"
  COVER_URI = 'https://api-v3.igdb.com/covers'
  ART_URI = 'https://api-v3.igdb.com/artworks'
  SCREENSHOTS_URI = 'https://api-v3.igdb.com/screenshots'
  RELEASE_URI = 'https://api-v3.igdb.com/release_dates/'
  
  GAME_SEARCH_URI = "https://api-v3.igdb.com/search"
  GAME_COLLECTION_URI = "https://api-v3.igdb.com/collections"
  
  USERKEY = 'ada77f859e3e4c235b5b6e360c79e249'
  UNIX_TIME_NOW = Time.current.to_time.to_i
  
  HTTP_CNF = Net::HTTP.new('api-v3.igdb.com', 80)
  
#NEED TO CATCH HTTP RESPONSE CODE BEFORE PROCEEDING!
#REFACTORING THE STRUCTURE OF CODE FOR REQUEST



  def gamesRequest(gameID)
    request = Net::HTTP::Get.new(URI(GAME_URI), {'user-key' => USERKEY})
    request.body = "fields name,summary; where id = #{gameID};";
    #puts request.body
    response = HTTP_CNF.request(request)
    JSON.parse(response.read_body)
  end
  
  
  def releaseDateRequest
    request = Net::HTTP::Get.new(URI(RELEASE_URI), {'user-key' => USERKEY})
    request.body = "fields name,summary; where id = #{gameID};";
    #request.body = "fields *; where game = #{gamesRequest.first['id']} & date > #{UNIX_TIME_NOW} & platform = 48;"
    request.body = "fields *; where game = #{gamesRequest.first['id']} & platform = 48;"
    response = HTTP_CNF.request(request)
    
    result = JSON.parse(response.read_body)  
    puts result
    releaseTime = result.first['date']
    DateTime.strptime(releaseTime.to_s,'%s').strftime("%A-%d-%m-%Y")
  end
      
  def gameCoverRequest(gameID)
      request = Net::HTTP::Get.new(URI(COVER_URI), {'user-key' => USERKEY})
      request.body = "fields name,summary; where id = #{gameID};";
      request.body = "fields url; where game = (#{gameID});"
      response = HTTP_CNF.request(request)
      
      if JSON.parse(response.read_body).empty?
         ' '
        else
          result = JSON.parse(response.read_body)
          #puts result
          result.first['url'].sub! 't_thumb','t_cover_big'
      end
  end

  def genericGameRequest
    
  end
  
  #This is used to search for a specific game. Initially, this just a hardcoded string to return details of a game
  def gamesSearchRequest
    request = Net::HTTP::Get.new(URI(GAME_SEARCH_URI), {'user-key' => USERKEY})
    request.body = 'fields *; where name = "Yakuza";'
    response = HTTP_CNF.request(request)
    #puts JSON.parse(response.read_body)
    JSON.parse(response.read_body)
  end
  
  #This is used to query for Video Games Series, 
  #result of collection are based on gamesSearchRequest
  def gamesSeriesRequest
    request = Net::HTTP::Get.new(URI(GAME_COLLECTION_URI), {'user-key' => USERKEY})
    request.body = "fields games; where id = (#{gamesSearchRequest.first['collection']}); limit 5;"
    JSON.parse(HTTP_CNF.request(request).read_body)
  end
  
  def gamesListProcess 
    games_id_array = gamesSeriesRequest.first['games']
    
    @game_card_list = []
    
    games_id_array[0...4].each do |x|
      game_card = {:name=>nil, :summary=> nil,:cover=>nil}  
      game_name = gamesRequest(x).first['name']
      game_card.store(:name,game_name)
      game_summary = gamesRequest(x).first['summary']
      game_card.store(:summary,game_summary)
      game_cover = gameCoverRequest(x)
      game_card.store(:cover,game_cover)
      
      @game_card_list << game_card
      
      puts "Current Game Card list #{@game_card_list}" 
    end
    @game_card_list 
   
  end

end