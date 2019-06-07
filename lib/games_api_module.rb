require 'uri'
require 'net/http'
module GamesApiModule
  
  #Utils Constant
  UNIX_TIME_NOW = Time.current.to_time.to_i
  HTTP_CNF = Net::HTTP.new('api-v3.igdb.com', 80)
  
  DUMMY_SCREENSHOT = [[{"id"=>244572, "game"=>55090, "height"=>720, "image_id"=>"iodd6zzceqq5jkufxpcz", "url"=>"//images.igdb.com/igdb/image/upload/t_1080p/iodd6zzceqq5jkufxpcz.jpg", "width"=>1280}, {"id"=>208211, "game"=>55090, "height"=>1080, "image_id"=>"wdsb42ukz39ywlzvhro4", "url"=>"//images.igdb.com/igdb/image/upload/t_1080p/wdsb42ukz39ywlzvhro4.jpg", "width"=>1920}, {"id"=>244573, "game"=>55090, "height"=>562, "image_id"=>"af8ueznswr8xpdkw9ukf", "url"=>"//images.igdb.com/igdb/image/upload/t_1080p/af8ueznswr8xpdkw9ukf.jpg", "width"=>1000}, {"id"=>208214, "game"=>55090, "height"=>1080, "image_id"=>"cxwpickwszhgdxvxdzzh", "url"=>"//images.igdb.com/igdb/image/upload/t_1080p/cxwpickwszhgdxvxdzzh.jpg", "width"=>1920}, {"id"=>208212, "game"=>55090, "height"=>1080, "image_id"=>"enex88ekm3se7a3vpqmp", "url"=>"//images.igdb.com/igdb/image/upload/t_1080p/enex88ekm3se7a3vpqmp.jpg", "width"=>1920}, {"id"=>208213, "game"=>55090, "height"=>1080, "image_id"=>"ywgv0zxrsocslwbkir8b", "url"=>"//images.igdb.com/igdb/image/upload/t_1080p/ywgv0zxrsocslwbkir8b.jpg", "width"=>1920}]]
  DUMMY_VIDEOS = ["https://www.youtube.com/embed/LVIdmEfiFCk","https://www.youtube.com/embed/OAQm-EzbaHM"]
  DUMMY_GAME_IDS = [{"id"=>2948, "games"=>[2268, 2269, 2271, 5316, 6440, 7075, 9692, 18181, 20427, 23066, 25623, 26901, 36926, 42759, 43668, 58601, 61701, 61752, 65676, 69721, 78626, 78629, 78630, 78631, 78633, 113344]}]
  
  #NEED TO CATCH HTTP RESPONSE CODE BEFORE PROCEEDING!
  #REFACTORING THE STRUCTURE OF CODE FOR REQUEST
  
  #General Information
  GAME_URI = "https://api-v3.igdb.com/games/"
  GAME_FRANCHISE_URI = "https://api-v3.igdb.com/franchises"
  
  #Media (Videos/Photos)
  COVER_URI = 'https://api-v3.igdb.com/covers'
  ARTWORK_URI = 'https://api-v3.igdb.com/artworks'
  SCREENSHOTS_URI = 'https://api-v3.igdb.com/screenshots'
  VIDEO_URI = 'https://api-v3.igdb.com/game_videos'
  
  PLATFORM_LOGO = 'https://api-v3.igdb.com/platform_logos'
  PLATFORM_URI ='https://api-v3.igdb.com/platforms'
  
  #Specific Info
  RELEASE_URI = 'https://api-v3.igdb.com/release_dates/'
  
  #Searching 
  GAME_SEARCH_URI = "https://api-v3.igdb.com/search"
  GAME_COLLECTION_URI = "https://api-v3.igdb.com/collections"
  
  
  #External Sites info
  GAME_NEWS_GROUP_URI = "https://api-v3.igdb.com/pulse_groups"
  GAME_ARTICLE_URI = "https://api-v3.igdb.com/pulses"
  GAME_EXTERNAL_ARTICLE_URI = "https://api-v3.igdb.com/pulse_urls"
  
  #GAME_NEWS_URI = "https://api-v3.igdb.com/feeds"
  
  #Authentication
  USERKEY = '049d27f7325bcb67768a30d5140fefb7'
  #anhtq2411 '049d27f7325bcb67768a30d5140fefb7' #EthuDev ada77f859e3e4c235b5b6e360c79e249
  

  def gamesRequest(game_id)
    puts "Called to Game Request with parameter: " << game_id.to_s
    request = Net::HTTP::Get.new(URI(GAME_URI), {'user-key' => USERKEY})
  
    #request.body = "fields *; where id = #{game_id};";
    request.body = "fields *,platforms.name,genres.name; where id = #{game_id};";
    #srequest.body = "fields name,summary; where id = #{gameID};";
    response = HTTP_CNF.request(request)
    JSON.parse(response.read_body)
  end
  
   #This is used to query for  Games Series,
  #result of collection are based on gamesSearchRequest
  def gamesSeriesRequest(collection_id)
    puts "Called to Game Series Request with parameter: " << collection_id.to_s
    request = Net::HTTP::Get.new(URI(GAME_COLLECTION_URI), {'user-key' => USERKEY})
    request.body = "fields games; where id = (#{collection_id}); limit 5;"
    result= JSON.parse(HTTP_CNF.request(request).read_body)
    result.first["games"] 
  end
  
  def gameFranchiseRequest(game_id)
    request = Net::HTTP::Get.new(URI(GAME_FRANCHISE_URI), {'user-key' => USERKEY})
    request.body = "fields *; where games = #{game_id};";
    response = HTTP_CNF.request(request)
    
    JSON.parse(response.read_body)
  end
  
  def gameNewsFeedRequest(game_id)
    puts "Called to News Feed Request with parameter: " << game_id.to_s
    request = Net::HTTP::Get.new(URI(GAME_NEWS_GROUP_URI), {'user-key' => USERKEY})
    request.body = "fields *; where game = #{game_id};"
    response = HTTP_CNF.request(request)
    result = JSON.parse(response.read_body)
    
    article_ids = []
    result.each do |rs|
      article_ids << rs["pulses"].join.to_i
    end
    
    puts "This is the list of article ID: " << article_ids[0..4].to_s
    article_ids[0..4]
    game_article_list = []
    article_ids[0..4].each do |id|
      game_article = gameArticleRequest(id)
      game_article_list << game_article
    end
    game_article_list
  end
    
  def gameArticleRequest(id)
    puts "Called to Game Article Request with parameter: " << id.to_s
    request = Net::HTTP::Get.new(URI(GAME_ARTICLE_URI), {'user-key' => USERKEY})
    request.body = "fields *; where id = #{id};"
    response = HTTP_CNF.request(request)
    
    game_article = {:id =>nil,:author=>nil,:summary=> nil,:img=>nil,:created_at=>nil,:title=>nil,:url=>nil}
    article_meta = JSON.parse(response.read_body).first
    
    #Constructing Article Hashes
    article_id = article_meta['id']
    game_article.store(:id,article_id)
    article_author = article_meta['name']
    game_article.store(:author,article_author)
    article_summary = article_meta['summary']
    game_article.store(:summary,article_summary)
    article_img = article_meta['image']
    game_article.store(:img,article_img)
    article_created_at = article_meta['created_at']
    game_article.store(:created_at,article_created_at)
    article_title = article_meta['title']
    game_article.store(:title,article_title)
    article_url = gameArticleExternalRequest(article_meta["website"])
    game_article.store(:url,article_url)
    
    game_article
  end
  
  def gameArticleExternalRequest(id)
    puts "Called to Game Article External Request with parameter: " << id.to_s
    request = Net::HTTP::Get.new(URI(GAME_EXTERNAL_ARTICLE_URI), {'user-key' => USERKEY})
    request.body = "fields *; where id = #{id};"
    
    response = HTTP_CNF.request(request)
    JSON.parse(response.read_body).first["url"]
  end

  def gamesPlatformLogoRequest(logo_id)
    request = Net::HTTP::Get.new(URI(PLATFORM_LOGO), {'user-key' => USERKEY})
   
    # request.body = "fields alpha_channel,animated,height,image_id,url,width;";
    request.body = 'fields *; where image_id = ' << logo_id << ';';
    response = HTTP_CNF.request(request)
    result = JSON.parse(response.read_body)
    img = []
    
    result.each do |res|
      img << res["url"]
    end
    img
  end
  
  def gamesPlatformRequest
    request = Net::HTTP::Get.new(URI(PLATFORM_URI), {'user-key' => USERKEY})
   
    request.body = "fields *;";
    response = HTTP_CNF.request(request)
    result = JSON.parse(response.read_body)
    puts result
    ids = []
    
    result.each do |res|
      ids << res["platform_logo"]
    end
    ids
  end
  
  def gameReleaseDateRequest
    puts "Called to Release Date Request with parameter: "
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
      
  def gameCoverRequest(game_id)
      puts "Called to Game Cover Request with parameter: " << game_id.to_s
      request = Net::HTTP::Get.new(URI(COVER_URI), {'user-key' => USERKEY})
      #request.body = "fields name,summary; where id = #{gameID};";
      request.body = "fields url; where game = (#{game_id});"
      response = HTTP_CNF.request(request)
      
      if JSON.parse(response.read_body).empty?
          nil
        else
          result = JSON.parse(response.read_body)
          result.first['url'].sub! 't_thumb','t_cover_big'
      end
  end
  
  def gameArtworkRequest(game_id)
      puts "Called to Game Artwork Request with parameter: " << game_id.to_s
      request = Net::HTTP::Get.new(URI(ARTWORK_URI), {'user-key' => USERKEY})
      request.body = "fields *; where game = (#{game_id});"
      response = HTTP_CNF.request(request)
      
      if JSON.parse(response.read_body).empty?
         ' '
        else
          result = JSON.parse(response.read_body)
          #puts result
          puts result
      end
  end

  #This is used to search for a specific game. Initially, this just a hardcoded string to return details of a game
  def gamesSearchRequest(game_string)
    puts "Called to Game Search Request with parameter: " << game_string
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
  
  def gameScreenshotRequest(game_id)
      puts "Called to Game Screenshots Request with parameter: " << game_id.to_s
      request = Net::HTTP::Get.new(URI(SCREENSHOTS_URI), {'user-key' => USERKEY})
      request.body = "fields *; where game = (#{game_id});"
      response = HTTP_CNF.request(request)
  
      if JSON.parse(response.read_body).empty?
          DUMMY_SCREENSHOT
        else
          result = JSON.parse(response.read_body)
          #Construct image format
          result.each do |screenshot|
            screenshot['url'].sub! 't_thumb','t_1080p'
          end
      end
  end
  
  def gamesVideoRequest(game_id)
    puts "Called to Game Video Request with parameter: " << game_id.to_s
    request = Net::HTTP::Get.new(URI(VIDEO_URI), {'user-key' => USERKEY})
    request.body = "fields *; where game = (#{game_id});"
    response = HTTP_CNF.request(request)
    
    game_videos_url = []
    
    if JSON.parse(response.read_body).empty?
          DUMMY_VIDEOS
        else
          #Construct YTB Embed url
          result = JSON.parse(response.read_body)
          result.each do |res|
          link = 'https://www.youtube.com/embed/'
          game_videos_url << (link << res["video_id"])
          end
          game_videos_url
    end
  end
  
  #
  def gamesListProcess(games_id_array)
    puts "Called to Game List Request with parameter: " << games_id_array.to_s
    game_card_list = []
    
    games_id_array[0..7].each do |x|
      #game_card = {:id =>nil,:name=>nil, :summary=> nil,:cover=>nil}
      
      game_card = {:id =>nil,:name=>nil, :summary=> nil,:cover=>nil,:first_release_date=>nil,:platform=>nil,:genres=>nil}
      game_detail = gamesRequest(x).first
      game_id = game_detail['id']
      game_card.store(:id,game_id)
      game_name = game_detail['name']
      game_card.store(:name,game_name)
      game_summary = game_detail['summary']
      game_card.store(:summary,game_summary)
      game_cover = gameCoverRequest(x)
      game_card.store(:cover,game_cover)
      
      unless (game_detail["platforms"].nil? or game_detail["genres"].nil? or game_detail["first_release_date"].nil? )
        game_platform = game_detail["platforms"].map{|x| x["name"]}.join(', ')
        game_card.store(:platform,game_platform)
        game_genres = game_detail["genres"].map{|x| x["name"]}.join(', ')
        game_card.store(:genres,game_genres)
        game_first_release_date = game_detail["first_release_date"]
      game_card.store(:first_release_date,DateTime.strptime(game_first_release_date.to_s,'%s').strftime("%A-%d-%b-%Y"))
      else
        game_card.store(:platform,"NA")
        game_card.store(:genres,"NA")
        game_card.store(:first_release_date,"NA")
      end
      game_card_list << game_card
      
    end
    game_card_list
  end
end