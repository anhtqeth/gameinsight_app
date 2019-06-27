require 'uri'
require 'net/http'
module GamesApiModule
  #Utils Constant
  UNIX_TIME_NOW = Time.current.to_time.to_i
  THIS_MONTH = (Time.now - 1.month).to_i
  HTTP_CNF = Net::HTTP.new('api-v3.igdb.com', 80)
  
  DUMMY_SCREENSHOT = [{"id"=>244572, "game"=>55090, "height"=>720, "image_id"=>"iodd6zzceqq5jkufxpcz", "url"=>"//images.igdb.com/igdb/image/upload/t_1080p/iodd6zzceqq5jkufxpcz.jpg", "width"=>1280}, {"id"=>208211, "game"=>55090, "height"=>1080, "image_id"=>"wdsb42ukz39ywlzvhro4", "url"=>"//images.igdb.com/igdb/image/upload/t_1080p/wdsb42ukz39ywlzvhro4.jpg", "width"=>1920}, {"id"=>244573, "game"=>55090, "height"=>562, "image_id"=>"af8ueznswr8xpdkw9ukf", "url"=>"//images.igdb.com/igdb/image/upload/t_1080p/af8ueznswr8xpdkw9ukf.jpg", "width"=>1000}, {"id"=>208214, "game"=>55090, "height"=>1080, "image_id"=>"cxwpickwszhgdxvxdzzh", "url"=>"//images.igdb.com/igdb/image/upload/t_1080p/cxwpickwszhgdxvxdzzh.jpg", "width"=>1920}, {"id"=>208212, "game"=>55090, "height"=>1080, "image_id"=>"enex88ekm3se7a3vpqmp", "url"=>"//images.igdb.com/igdb/image/upload/t_1080p/enex88ekm3se7a3vpqmp.jpg", "width"=>1920}, {"id"=>208213, "game"=>55090, "height"=>1080, "image_id"=>"ywgv0zxrsocslwbkir8b", "url"=>"//images.igdb.com/igdb/image/upload/t_1080p/ywgv0zxrsocslwbkir8b.jpg", "width"=>1920}]
  DUMMY_VIDEOS = ["https://www.youtube.com/embed/LVIdmEfiFCk","https://www.youtube.com/embed/OAQm-EzbaHM"]
  DUMMY_GAME_IDS = [{"id"=>2948, "games"=>[2268, 2269, 2271, 5316, 6440, 7075, 9692, 18181, 20427, 23066, 25623, 26901, 36926, 42759, 43668, 58601, 61701, 61752, 65676, 69721, 78626, 78629, 78630, 78631, 78633, 113344]}]
  DUMMY_NEWS = [{:id=>261029, :author=>nil, :summary=>"Sega will apparently continue to remaster the series, with Yakuza 2 the next in line for a remake using the Yakuza 6 engine.", :img=>"https://static.gamespot.com/uploads/screen_kubrick/123/1239113/3277876-yakuza.jpg", :created_at=>1503619200, :title=>"PSN Leak Reveals Yakuza 2 Is Now Getting A PS4 Remake", :url=>"https://www.gamespot.com/articles/psn-leak-reveals-yakuza-2-is-now-getting-a-ps4-rem/1100-6452857/"},{:id=>261029, :author=>nil, :summary=>"Sega will apparently continue to remaster the series, with Yakuza 2 the next in line for a remake using the Yakuza 6 engine.", :img=>"https://static.gamespot.com/uploads/screen_kubrick/123/1239113/3277876-yakuza.jpg", :created_at=>1503619200, :title=>"PSN Leak Reveals Yakuza 2 Is Now Getting A PS4 Remake", :url=>"https://www.gamespot.com/articles/psn-leak-reveals-yakuza-2-is-now-getting-a-ps4-rem/1100-6452857/"}]
  DUMMY_ARTICLE = {:id=>261029, :author=>nil, :summary=>"Sega will apparently continue to remaster the series, with Yakuza 2 the next in line for a remake using the Yakuza 6 engine.", :img=>"https://static.gamespot.com/uploads/screen_kubrick/123/1239113/3277876-yakuza.jpg", :created_at=>1503619200, :title=>"PSN Leak Reveals Yakuza 2 Is Now Getting A PS4 Remake", :url=>"https://www.gamespot.com/articles/psn-leak-reveals-yakuza-2-is-now-getting-a-ps4-rem/1100-6452857/"}
  DUMMY_GAME_CARDS = [{:id=>2059, :name=>"Yakuza", :summary=>"Just as Kazuma, a former rising star in the Yakuza, emerges from prison after a murder cover-up, 10 billion yen vanishes from the Yakuza vault, forcing him once again into their brutal, lawless world. A mysterious young girl will lead Kazuma to the answers if he can keep her alive.", :cover=>"//images.igdb.com/igdb/image/upload/t_cover_big/e3cdy0d77eduopr5en37.jpg"}, {:id=>2060, :name=>"Yakuza 2", :summary=>"Yakuza 2 plunges you once more into the violent Japanese underworld. In intense brutal clashes with rival gangs, the police, and the Korean mafia, you will have opportunities to dole out more brutal punishment. As the heroic Kazuma Kiryu from the original Yakuza, explore Tokyo and now Osaka. Wander through the back alleys of Japan's underworld while trying to prevent an all-out gang war in over 16 complex, cinematic chapters written by Hase Seishu, the famous Japanese author who also wrote the first Yakuza. Endless conflicts and surprise plot twists will immerse you in a dark shadowy world where only the strongest will survive.", :cover=>"//images.igdb.com/igdb/image/upload/t_cover_big/ozhhq6bsu5elgkhbraoe.jpg"}, {:id=>2061, :name=>"Yakuza 3", :summary=>"Introducing the next cinematic chapter in the prestigious Yakuza series renowned for it's authentic, gritty and often violent look at modern Japan. Making its first appearance exclusively on the PlayStation 3 computer entertainment system, the rich story and vibrant world of Yakuza 3 lets players engage in intense brutal clashes within the streets of Okinawa, and the vibrant and often dangerous city of Tokyo where only the strongest will survive.", :cover=>"//images.igdb.com/igdb/image/upload/t_cover_big/amhmvuaybvl0epgcpfys.jpg"}, {:id=>2062, :name=>"Yakuza 4", :summary=>"Yakuza 4 is the fourth game in Sega's crime drama series, known as 'Ryu ga Gotoku' in Japan. As a first for the series, the story is split between the viewpoints of four different protagonists.", :cover=>"//images.igdb.com/igdb/image/upload/t_cover_big/udb2eilafrf5yujesuq8.jpg"}]
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
  
  INVOLVED_COMS_URI = 'https://api-v3.igdb.com/involved_companies'
  COMPANIES_URI = 'https://api-v3.igdb.com/companies'
  
  # PLATFORM_LOGO = 'https://api-v3.igdb.com/platform_logos'
  # PLATFORM_URI ='https://api-v3.igdb.com/platforms'
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
  
  MESS_NA_SERIES = "There are no series related to this game. Or did we missed it?"
  
  #Authentication
  USERKEY = '931298283bd07e530bad4ab6110dbc9e'
  #DeviJack 931298283bd07e530bad4ab6110dbc9e
  #anhtq2411 '049d27f7325bcb67768a30d5140fefb7' #EthuDev ada77f859e3e4c235b5b6e360c79e249
  
  def buildRequest(uri)
    request = Net::HTTP::Get.new(URI(uri), {'user-key' => USERKEY})
    request
  end
  
  def gamesRequest(game_id)
    puts "Called to Game Request with parameter: " << game_id.to_s
    request = buildRequest(GAME_URI)
    #request.body = "fields *; where id = #{game_id};";
    request.body = "fields *,platforms.name,genres.name; where id = #{game_id};";
    #srequest.body = "fields name,summary; where id = #{gameID};";
    response = HTTP_CNF.request(request)
    JSON.parse(response.read_body)
  end
  
  def involvedCompaniesRequest(game_id)
    puts "Called to Involved Company Request with parameter: " << game_id.to_s
    request = buildRequest(INVOLVED_COMS_URI)
    
    companies = []
    
    request.body = "fields *; where game = #{game_id};";
    response = HTTP_CNF.request(request)
    result = JSON.parse(response.read_body)
    result.each do |rs|
      company = {:id => nil, :type => nil}  
      company[:id] = rs["company"]
      
      if rs["developer"]
        company[:type] = 'Developer'
        else if rs["publisher"]
          company[:type] = 'Publisher'
        end
      end
      companies << company
    end
    puts companies
    companies
  end
  
  def gameCompaniesRequest(game_id,company_type) #
    puts "Called to Game Companies Request with game ID : " << game_id.to_s << " and company type: " << company_type
    companies = involvedCompaniesRequest(game_id)
    
    company_id = nil
    case company_type
      when 'Publisher'
        puts 'PUBLISHER ID QUERY'
        company_id = companies.select{|c| c[:type] == 'Publisher'}.map{|x| x[:id] }.join.to_i
        #request.body = "fields *; where published = #{game_id};"
      when 'Developer'
        puts 'DEVELOPER ID QUERY'
        company_id = companies.select{|c| c[:type] == 'Developer'}.map{|x| x[:id] }.join.to_i
        #request.body = "fields *; where developed = #{game_id};"
      else
      "Please specify what company type you wish for #{company_type}"
    end
    
    request = Net::HTTP::Get.new(URI(COMPANIES_URI), {'user-key' => USERKEY})
    request.body = "fields *; where id = #{company_id};"  #where published = #{game_id};
    response = HTTP_CNF.request(request)
    result = JSON.parse(response.read_body)
    if result.empty? 
      {:external_id => 'NA', :name => 'NA',:description => 'NA',:websites => 'NA'}
    else
      puts "Result here: " << result.to_s
      gameCompanyProcess(result.first)
    end
  end
  #TODO Add field as needed
  def gameCompanyProcess(company_meta)
    company_detail = {:external_id => nil, :name => nil,:description => nil,:websites => nil}
    
    external_id = company_meta['id']
    company_detail.store(:external_id,external_id)
    company_name = company_meta['name']
    company_detail.store(:name,company_name)
    company_description = company_meta['description']
    company_detail.store(:description,company_description)
    company_website = company_meta['websites']
    company_detail.store(:websites,company_website)
    
    company_detail
  end
  
  #This is used to query for  Games Series,
  #result of collection are based on gamesSearchRequest
  def gamesSeriesRequest(collection_id)
    puts "Called to Game Series Request with parameter: " << collection_id.to_s
    request = Net::HTTP::Get.new(URI(GAME_COLLECTION_URI), {'user-key' => USERKEY})
    request.body = "fields games; where id = (#{collection_id}); limit 5;"
    result= JSON.parse(HTTP_CNF.request(request).read_body)
    if result.empty?
      MESS_NA_SERIES
    else
      result.first["games"] 
    end
  end
  
  def gameArticleProcess(article_meta)
    game_article = {:id =>nil,:author=>nil,:summary=> nil,:img=>nil,:created_at=>nil,:title=>nil,:url=>nil,:news_source=>nil}
   
    article_id = article_meta['id']
    game_article.store(:id,article_id)
    article_author = article_meta['author']
    game_article.store(:author,article_author)
    article_summary = article_meta['summary']
    game_article.store(:summary,article_summary)
    article_img = article_meta['image']
    game_article.store(:img,article_img)
    article_created_at = article_meta['created_at']
    game_article.store(:created_at,DateTime.strptime(article_created_at.to_s,'%s').strftime("%A-%d-%b-%Y-%R"))
    article_title = article_meta['title']
    game_article.store(:title,article_title)
    article_url = gameArticleExternalRequest(article_meta["website"])
    game_article.store(:url,article_url)
    news_source = PublicSuffix.parse(URI.parse(article_url).host).sld
    game_article.store(:news_source,news_source)
    
    puts game_article
    game_article
  end
  
  def gameLatestNewsRequest(time)
    puts "Called to Latest Feed Request with parameter: " << DateTime.strptime(time.to_s,'%s').strftime("%A-%d-%b-%Y")
    request = buildRequest(GAME_ARTICLE_URI)
    request.body = "fields *; where published_at > #{time};limit 12;"
    response = HTTP_CNF.request(request)
    result = JSON.parse(response.read_body)
    puts result
    game_article_list = []
    
    if result.nil?
      DUMMY_NEWS
    else
      result.each do |article_meta|
      #Constructing Article Hashes
      game_article = gameArticleProcess(article_meta)
      game_article_list << game_article
      end
    end
    game_article_list
  end
  
  #Get Related News from multiple sources for a game
  def gameNewsFeedRequest(game_id)
    puts "Called to News Feed Request with parameter: " << game_id.to_s
    request = Net::HTTP::Get.new(URI(GAME_NEWS_GROUP_URI), {'user-key' => USERKEY})
    request.body = "fields *; where game = #{game_id};"
    response = HTTP_CNF.request(request)
    result = JSON.parse(response.read_body)
    article_ids = []
    
    if result.empty?
      DUMMY_NEWS
    else
      puts 'Current Result: ' << result.to_s
      result.each do |rs|
        article_ids << rs["pulses"].join(",").to_i
      end
    end
    puts "This is the list of article ID: " << article_ids.to_s
    
    if article_ids.empty?
      DUMMY_NEWS
    else
      game_article_list = []
      article_ids.each do |id|
        game_article = gameArticleRequest(id)
        unless game_article.nil?
          game_article_list << game_article
        end
      end
      game_article_list
    end
  end
    
  def gameArticleRequest(id)
    puts "Called to Game Article Request with parameter: " << id.to_s
    request = Net::HTTP::Get.new(URI(GAME_ARTICLE_URI), {'user-key' => USERKEY})
    request.body = "fields *; where id = #{id};"
    response = HTTP_CNF.request(request)
    
    game_article = {:id =>nil,:author=>nil,:summary=> nil,:img=>nil,:created_at=>nil,:title=>nil,:url=>nil}
    article_meta = JSON.parse(response.read_body).first
    if article_meta.nil?
      DUMMY_ARTICLE
    else
      #Constructing Article Hashes
      game_article = gameArticleProcess(article_meta)
    end
  end
  
  def gameArticleExternalRequest(id)
    puts "Called to Game Article External Request with parameter: " << id.to_s
    request = Net::HTTP::Get.new(URI(GAME_EXTERNAL_ARTICLE_URI), {'user-key' => USERKEY})
    request.body = "fields *; where id = #{id};"
    
    response = HTTP_CNF.request(request)
    puts JSON.parse(response.read_body)
    puts JSON.parse(response.read_body).first["url"]
    JSON.parse(response.read_body).first["url"]
  end
  
  def gameRecentRelease(platform)
    puts "Called to Recent Released Game Request"
    request = Net::HTTP::Get.new(URI(RELEASE_URI), {'user-key' => USERKEY})
    platform_id = nil;
    month = Time.now.month
    case platform 
      when 'PlayStation'
        platform_id = 48
      when 'Microsoft Xbox'
        platform_id = 9
      when 'PC'
        platform_id = 46
      when 'Nintendo Switch'
        platform_id = 130
      when 'iOS'
        platform_id = 39
      #TODO Add more platforms  
      else
        puts "(#{platform}) is not a valid platform"
    end
    
    request.body = "fields *,game.name; where date < #{UNIX_TIME_NOW} & m =#{month} & y=2019 & game.platforms = #{platform_id}; sort m desc; limit 20;"
    puts request.body
    response = HTTP_CNF.request(request)
    result = JSON.parse(response.read_body)  
    puts result
    result
  end
  
  def gamePopularUpcomingRelease
    puts "Called to Popular Upcoming Release game"
    request = Net::HTTP::Get.new(URI(GAME_URI), {'user-key' => USERKEY})
    request.body = "fields *; where first_release_date > #{UNIX_TIME_NOW} & popularity > 200.0; sort popularity desc;"
    #request.body = "fields *; where first_release_date > #{UNIX_TIME_NOW} & hypes > 500; sort hypes desc;"

    response = HTTP_CNF.request(request)
    result = JSON.parse(response.read_body)  
    ids_array = []
    result.each do |x|
      ids_array << x["id"]
    end
    
    puts ids_array
    ids_array
  end
  
  def gameReleaseDateRequest
    puts "Called to Release Date Request with parameter: "
    request = Net::HTTP::Get.new(URI(RELEASE_URI), {'user-key' => USERKEY})
    request.body = "fields *; where date > #{UNIX_TIME_NOW}"
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
  
  def gameCardProcess(game_card,game_detail)
      game_id = game_detail['id']
      game_card.store(:id,game_id)
      game_name = game_detail['name']
      game_card.store(:name,game_name)
      game_summary = game_detail['summary']
      game_card.store(:summary,game_summary)
      game_storyline = game_detail['storyline']
      game_card.store(:storyline,game_storyline)
      game_cover = gameCoverRequest(game_id)
      game_card.store(:cover,game_cover)
    unless (game_detail["platforms"].nil? or game_detail["genres"].nil? or game_detail["first_release_date"].nil? )
      game_platform = game_detail["platforms"].map{|x| x["name"]}.join(', ')
      game_card.store(:platform,game_platform)
      game_genres = game_detail["genres"].map{|x| x["name"]}.join(', ')
      game_card.store(:genres,game_genres)
      game_first_release_date = game_detail["first_release_date"]
      # game_card.store(:first_release_date,DateTime.strptime(game_first_release_date.to_s,'%s').strftime("%A-%d-%b-%Y"))
      game_card.store(:first_release_date,game_first_release_date)
    else
      game_card.store(:platform,"NA")
      game_card.store(:genres,"NA")
      game_card.store(:first_release_date,"NA")
    end
    game_card
  end
  
  def gamesListProcess(games_id_array)
    puts "Called to Game List Request with parameter: " << games_id_array.to_s
    game_card_list = []
    
    if games_id_array.is_a? Array
      games_id_array[0..7].each do |x|
      #game_card = {:id =>nil,:name=>nil, :summary=> nil,:cover=>nil}
      game_card = {:id =>nil,:name=>nil, :summary=> nil,:storyline => nil,:cover=>nil,:first_release_date=>nil,:platform=>nil,:genres=>nil}
      game_detail = gamesRequest(x).first
      game_card = gameCardProcess(game_card,game_detail)
      game_card_list << game_card
      end
      game_card_list
    else 
      puts "Go through here...."
      game_card = {:id =>nil,:name=>nil, :summary=> nil,:storyline => nil,:cover=>nil,:first_release_date=>nil,:platform=>nil,:genres=>nil}
      game_detail = gamesRequest(games_id_array).first
      game_card = gameCardProcess(game_card,game_detail)
      game_card
    end
  end
  
   # def gamesPlatformLogoRequest(logo_id)
  #   request = Net::HTTP::Get.new(URI(PLATFORM_LOGO), {'user-key' => USERKEY})
   
  #   # request.body = "fields alpha_channel,animated,height,image_id,url,width;";
  #   request.body = 'fields *; where image_id = ' << logo_id << ';';
  #   response = HTTP_CNF.request(request)
  #   result = JSON.parse(response.read_body)
  #   img = []
    
  #   result.each do |res|
  #     img << res["url"]
  #   end
  #   img
  # end
  
  # def gamesPlatformRequest
  #   request = Net::HTTP::Get.new(URI(PLATFORM_URI), {'user-key' => USERKEY})
   
  #   request.body = "fields *;";
  #   response = HTTP_CNF.request(request)
  #   result = JSON.parse(response.read_body)
  #   puts result
  #   ids = []
    
  #   result.each do |res|
  #     ids << res["platform_logo"]
  #   end
  #   ids
  # end
end