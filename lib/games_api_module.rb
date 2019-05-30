require 'uri'
require 'net/http'
module GamesApiModule
  
  #General Information
  GAME_URI = "https://api-v3.igdb.com/games/"
  #Media (Videos/Photos)
  COVER_URI = 'https://api-v3.igdb.com/covers'
  ARTWORK_URI = 'https://api-v3.igdb.com/artworks'
  SCREENSHOTS_URI = 'https://api-v3.igdb.com/screenshots'
  VIDEO_URI = 'https://api-v3.igdb.com/game_videos'
  
  #Specific Info
  RELEASE_URI = 'https://api-v3.igdb.com/release_dates/'
  
  #Searching 
  GAME_SEARCH_URI = "https://api-v3.igdb.com/search"
  GAME_COLLECTION_URI = "https://api-v3.igdb.com/collections"
  
  #Authentication
  USERKEY = '049d27f7325bcb67768a30d5140fefb7'
  #anhtq2411 '049d27f7325bcb67768a30d5140fefb7' #EthuDev ada77f859e3e4c235b5b6e360c79e249
  
  #Utils Constant
  UNIX_TIME_NOW = Time.current.to_time.to_i
  HTTP_CNF = Net::HTTP.new('api-v3.igdb.com', 80)
  
#NEED TO CATCH HTTP RESPONSE CODE BEFORE PROCEEDING!
#REFACTORING THE STRUCTURE OF CODE FOR REQUEST



  def gamesRequest(game_id)
    request = Net::HTTP::Get.new(URI(GAME_URI), {'user-key' => USERKEY})
  
    request.body = "fields *; where id = #{game_id};";
    #srequest.body = "fields name,summary; where id = #{gameID};";
    response = HTTP_CNF.request(request)
    JSON.parse(response.read_body)
  end
  
  def gameReleaseDateRequest
    request = Net::HTTP::Get.new(URI(RELEASE_URI), {'user-key' => USERKEY})
    request.body = "fields *; where date > #{UNIX_TIME_NOW}  & platform = 48;"
    response = HTTP_CNF.request(request)
    
    result = JSON.parse(response.read_body)  
    #releaseTime = result.first['date']
    
    result.each do |x|
      x['date'] = DateTime.strptime(x['date'].to_s,'%s').strftime("%A-%d-%b-%Y")
    end
    result
  end
      
  def gameCoverRequest(gameID)
      request = Net::HTTP::Get.new(URI(COVER_URI), {'user-key' => USERKEY})
      #request.body = "fields name,summary; where id = #{gameID};";
      request.body = "fields url; where game = (#{gameID});"
      response = HTTP_CNF.request(request)
      
      if JSON.parse(response.read_body).empty?
          nil
        else
          result = JSON.parse(response.read_body)
          puts 'COVER ART REQUEST!! ' << result.to_s
          result.first['url'].sub! 't_thumb','t_cover_big'
      end
  end
  
  def gameArtworkRequest(gameID)
      request = Net::HTTP::Get.new(URI(ARTWORK_URI), {'user-key' => USERKEY})
      request.body = "fields *; where game = (#{gameID});"
      response = HTTP_CNF.request(request)
      
      if JSON.parse(response.read_body).empty?
         ' '
        else
          result = JSON.parse(response.read_body)
          #puts result
          puts result
      end
  end

  def gameScreenshotRequest(gameID)
      request = Net::HTTP::Get.new(URI(SCREENSHOTS_URI), {'user-key' => USERKEY})
      request.body = "fields *; where game = (#{gameID});"
      response = HTTP_CNF.request(request)
      
      if JSON.parse(response.read_body).empty?
         ''
        else
          result = JSON.parse(response.read_body)
          #puts result
          result.each do |screenshot|
            screenshot['url'].sub! 't_thumb','t_1080p'
          end
      end
  end

  def genericGameRequest #This was firstly created to randomly pick a game details
    
  end
  
  #This is used to search for a specific game. Initially, this just a hardcoded string to return details of a game
  def gamesSearchRequest(game_string)
    request = Net::HTTP::Get.new(URI(GAME_URI), {'user-key' => USERKEY})
    #request.body = 'fields *; where name = "' << game_string << '";' QUERY FOR GAME_SEARCH_URI
    request.body  = 'search " '<< game_string << '";'
    puts request.body
    response = HTTP_CNF.request(request)
    #puts JSON.parse(response.read_body)
    result = JSON.parse(response.read_body)
    game_ids = []
    result.each do |x|
      game_ids << x["id"]
    end
    game_ids
  end
  
  #This is used to query for  Games Series,
  #result of collection are based on gamesSearchRequest
  def gamesSeriesRequest(collection_id)
    request = Net::HTTP::Get.new(URI(GAME_COLLECTION_URI), {'user-key' => USERKEY})
    request.body = "fields games; where id = (#{collection_id}); limit 5;"
    JSON.parse(HTTP_CNF.request(request).read_body)
  end
  
  def gamesVideoRequest(game_id)
    request = Net::HTTP::Get.new(URI(VIDEO_URI), {'user-key' => USERKEY})
    request.body = "fields *; where game = (#{game_id});"
    
    game_videos_url = []
    result = JSON.parse(HTTP_CNF.request(request).read_body)
    
    #Construct YTB Embed url
    result.each do |res|
      link = 'https://www.youtube.com/embed/'
      game_videos_url << (link << res["video_id"])
    end
    game_videos_url
  end
  
  #
  def gamesListProcess(games_id_array)
    game_card_list = []
    
    games_id_array[0...4].each do |x|
      game_card = {:id =>nil,:name=>nil, :summary=> nil,:cover=>nil}
      game_id = gamesRequest(x).first['id']
      game_card.store(:id,game_id)
      game_name = gamesRequest(x).first['name']
      game_card.store(:name,game_name)
      game_summary = gamesRequest(x).first['summary']
      game_card.store(:summary,game_summary)
      game_cover = gameCoverRequest(x)
      game_card.store(:cover,game_cover)
      
      game_card_list << game_card
      
    end
    game_card_list
  end
end