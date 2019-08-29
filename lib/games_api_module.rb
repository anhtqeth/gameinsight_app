require 'uri'
require 'open-uri'
require 'net/http'

#GamesApiModule - Used to handle request to fetch API data of video games.
#Author - Anh Truong
#Date Added - 17 - May - 2019
#Each request will send a call to an api enpoint. 
#On some occasion, the response will be constructed to a hash
#The request data will then be processed by Active Model

#TODO - Store constant in another file
#TODO - Refactor code
#TODO - Reduce code smell
#TODO - Handle nil result or empty image within this lib
#TODO - Integrated asset to be empty placeholder for media like vid/img
#TODO - Remove DUMMY values
#TODO - Store API authorization somewhere safe

module GamesApiModule
  #Utils Constant
  UNIX_TIME_NOW = Time.current.to_time.to_i
  THIS_MONTH = (Time.now - 1.month).to_i
  
  # HTTP_CNF = Net::HTTP.new('api-v3.igdb.com', 443)
  # HTTP_CNF.use_ssl = true 
  
  DUMMY_SCREENSHOT = [{"id"=>244572, "game"=>55090, "height"=>720, "image_id"=>"iodd6zzceqq5jkufxpcz", "url"=>"//images.igdb.com/igdb/image/upload/t_1080p/iodd6zzceqq5jkufxpcz.jpg", "width"=>1280}, {"id"=>208211, "game"=>55090, "height"=>1080, "image_id"=>"wdsb42ukz39ywlzvhro4", "url"=>"//images.igdb.com/igdb/image/upload/t_1080p/wdsb42ukz39ywlzvhro4.jpg", "width"=>1920}, {"id"=>244573, "game"=>55090, "height"=>562, "image_id"=>"af8ueznswr8xpdkw9ukf", "url"=>"//images.igdb.com/igdb/image/upload/t_1080p/af8ueznswr8xpdkw9ukf.jpg", "width"=>1000}, {"id"=>208214, "game"=>55090, "height"=>1080, "image_id"=>"cxwpickwszhgdxvxdzzh", "url"=>"//images.igdb.com/igdb/image/upload/t_1080p/cxwpickwszhgdxvxdzzh.jpg", "width"=>1920}, {"id"=>208212, "game"=>55090, "height"=>1080, "image_id"=>"enex88ekm3se7a3vpqmp", "url"=>"//images.igdb.com/igdb/image/upload/t_1080p/enex88ekm3se7a3vpqmp.jpg", "width"=>1920}, {"id"=>208213, "game"=>55090, "height"=>1080, "image_id"=>"ywgv0zxrsocslwbkir8b", "url"=>"//images.igdb.com/igdb/image/upload/t_1080p/ywgv0zxrsocslwbkir8b.jpg", "width"=>1920}]
  DUMMY_VIDEOS = ["https://www.youtube.com/embed/LVIdmEfiFCk","https://www.youtube.com/embed/OAQm-EzbaHM"]
  DUMMY_GAME_IDS = [{"id"=>2948, "games"=>[2268, 2269, 2271, 5316, 6440, 7075, 9692, 18181, 20427, 23066, 25623, 26901, 36926, 42759, 43668, 58601, 61701, 61752, 65676, 69721, 78626, 78629, 78630, 78631, 78633, 113344]}]
  DUMMY_NEWS = [{:id=>261029, :author=>nil, :summary=>"Sega will apparently continue to remaster the series, with Yakuza 2 the next in line for a remake using the Yakuza 6 engine.", :img=>"https://static.gamespot.com/uploads/screen_kubrick/123/1239113/3277876-yakuza.jpg", :created_at=>1503619200, :title=>"PSN Leak Reveals Yakuza 2 Is Now Getting A PS4 Remake", :url=>"https://www.gamespot.com/articles/psn-leak-reveals-yakuza-2-is-now-getting-a-ps4-rem/1100-6452857/"},{:id=>261029, :author=>nil, :summary=>"Sega will apparently continue to remaster the series, with Yakuza 2 the next in line for a remake using the Yakuza 6 engine.", :img=>"https://static.gamespot.com/uploads/screen_kubrick/123/1239113/3277876-yakuza.jpg", :created_at=>1503619200, :title=>"PSN Leak Reveals Yakuza 2 Is Now Getting A PS4 Remake", :url=>"https://www.gamespot.com/articles/psn-leak-reveals-yakuza-2-is-now-getting-a-ps4-rem/1100-6452857/"}]
  DUMMY_ARTICLE = {:id=>261029, :author=>nil, :summary=>"Sega will apparently continue to remaster the series, with Yakuza 2 the next in line for a remake using the Yakuza 6 engine.", :img=>"https://static.gamespot.com/uploads/screen_kubrick/123/1239113/3277876-yakuza.jpg", :created_at=>1503619200, :title=>"PSN Leak Reveals Yakuza 2 Is Now Getting A PS4 Remake", :url=>"https://www.gamespot.com/articles/psn-leak-reveals-yakuza-2-is-now-getting-a-ps4-rem/1100-6452857/"}
  DUMMY_GAME_CARDS = [{:id=>2059, :name=>"Yakuza", :summary=>"Just as Kazuma, a former rising star in the Yakuza, emerges from prison after a murder cover-up, 10 billion yen vanishes from the Yakuza vault, forcing him once again into their brutal, lawless world. A mysterious young girl will lead Kazuma to the answers if he can keep her alive.", :cover=>"//images.igdb.com/igdb/image/upload/t_cover_big/e3cdy0d77eduopr5en37.jpg"}, {:id=>2060, :name=>"Yakuza 2", :summary=>"Yakuza 2 plunges you once more into the violent Japanese underworld. In intense brutal clashes with rival gangs, the police, and the Korean mafia, you will have opportunities to dole out more brutal punishment. As the heroic Kazuma Kiryu from the original Yakuza, explore Tokyo and now Osaka. Wander through the back alleys of Japan's underworld while trying to prevent an all-out gang war in over 16 complex, cinematic chapters written by Hase Seishu, the famous Japanese author who also wrote the first Yakuza. Endless conflicts and surprise plot twists will immerse you in a dark shadowy world where only the strongest will survive.", :cover=>"//images.igdb.com/igdb/image/upload/t_cover_big/ozhhq6bsu5elgkhbraoe.jpg"}, {:id=>2061, :name=>"Yakuza 3", :summary=>"Introducing the next cinematic chapter in the prestigious Yakuza series renowned for it's authentic, gritty and often violent look at modern Japan. Making its first appearance exclusively on the PlayStation 3 computer entertainment system, the rich story and vibrant world of Yakuza 3 lets players engage in intense brutal clashes within the streets of Okinawa, and the vibrant and often dangerous city of Tokyo where only the strongest will survive.", :cover=>"//images.igdb.com/igdb/image/upload/t_cover_big/amhmvuaybvl0epgcpfys.jpg"}, {:id=>2062, :name=>"Yakuza 4", :summary=>"Yakuza 4 is the fourth game in Sega's crime drama series, known as 'Ryu ga Gotoku' in Japan. As a first for the series, the story is split between the viewpoints of four different protagonists.", :cover=>"//images.igdb.com/igdb/image/upload/t_cover_big/udb2eilafrf5yujesuq8.jpg"}]
  #NEED TO CATCH HTTP RESPONSE CODE BEFORE PROCEEDING!
  #REFACTORING THE STRUCTURE OF CODE FOR REQUEST
  
  BASE_URI = 'https://api-v3.igdb.com/'
  
  #General Information
  GAME_URI = 'https://api-v3.igdb.com/games/'
  GAME_FRANCHISE_URI = "https://api-v3.igdb.com/franchises"
  GAME_GENRE = 'https://api-v3.igdb.com/genres'
  
  #Media (Videos/Photos)
  COVER_URI = 'https://api-v3.igdb.com/covers'
  ARTWORK_URI = 'https://api-v3.igdb.com/artworks'
  SCREENSHOTS_URI = 'https://api-v3.igdb.com/screenshots'
  VIDEO_URI = 'https://api-v3.igdb.com/game_videos'
  
  INVOLVED_COMS_URI = 'https://api-v3.igdb.com/involved_companies'
  COMPANIES_URI = 'https://api-v3.igdb.com/companies'
  
  # PLATFORM_LOGO = 'https://api-v3.igdb.com/platform_logos'
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
  
  MESS_NA_SERIES = "There are no series related to this game. Or did we missed it?"
  
  #Authentication
  USERKEY = 'ada77f859e3e4c235b5b6e360c79e249'
  #DeviJack ec80dc20b6c9b360aab19868b02ed17e
  #anhtq2411 '049d27f7325bcb67768a30d5140fefb7' #EthuDev ada77f859e3e4c235b5b6e360c79e249
  
  # http = Net::HTTP.new('api-v3.igdb.com', 80)
  # request = Net::HTTP::Get.new(URI('https://api-v3.igdb.com/achievements'), {'user-key' => YOUR_KEY})
  # request.body = 'fields *'
  # puts http.request(request).body
  
  #http_construct = Net::HTTP.new('api-v3.igdb.com', 80)
  
  def buildRequest(uri)
    url = URI(uri)
    request = Net::HTTP::Get.new(url, {'user-key' => USERKEY})
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    request
  end

  def gamesRequest(game_id)
    puts "Called to Game Request with parameter: " << game_id.to_s
    request = buildRequest(GAME_URI)
    #request.body = "fields *,platforms.name,genres.name; where id = #{game_id};";
    request.body = "fields *; where id = #{game_id};"
    response = http_construct.request(request)
    #puts response.read_body
    JSON.parse(response.read_body)
  end
  
  def http_construct
    http_cnf = Net::HTTP.new('api-v3.igdb.com', 443)
    http_cnf.use_ssl = true 
    http_cnf
  end
  
  def gameGenreRequest(id)
    puts "Called to Genre Request..."
    request = buildRequest(GAME_GENRE)
    if id.nil?
      request.body = "fields id; limit 25;";
    else
      request.body = "fields *; where id = #{id};"
    end
    
    response = http_construct.request(request)
    puts response.read_body
    JSON.parse(response.read_body).first
  end
  
  def involvedCompaniesRequest(game_id)
    puts "Called to Involved Company Request with parameter: " << game_id.to_s
    request = buildRequest(INVOLVED_COMS_URI)
    
    companies = []
    
    request.body = "fields *; where game = #{game_id};";
    response = http_construct.request(request)
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
  
  #gameCompaniesRequest
  #Fetch data base on game_external_id & company_type
  #Using company_type to get the id for Company Detail request
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
    request.body = "fields *; where id = #{company_id};"
    response = http_construct.request(request)
    result = JSON.parse(response.read_body)
    if result.empty? 
      {:external_id => 'NA', :name => 'NA',:description => 'NA',:websites => 'NA'}
    else
      # puts "Result here: " << result.to_s
      result.first
      #gameCompanyProcess(result.first)
    end
  end
  #TODO Add field as needed
  #gameCompanyProcess
  #Using data from api to constructing hashes for game company
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
  def gamesSeriesRequest(game_id)
    puts "Called to Game Series Request with parameter: " << game_id.to_s
    request = Net::HTTP::Get.new(URI(GAME_COLLECTION_URI), {'user-key' => USERKEY})
    request.body = "fields *; where games = [#{game_id}];"
    result= JSON.parse(http_construct.request(request).read_body)
    if result.empty?
      nil
    else
      result.first
    end
  end
  
  def gameArticleProcess(article_meta)
    puts "Processing Article"
    game_article = {:id =>nil,:author=>nil,:summary=> nil,:img=>nil,
    :created_at=>nil,:title=>nil,:url=>nil,:news_source=>nil}
    game_article.store(:id,article_meta['id'])
    game_article.store(:author,article_meta['author'])
    game_article.store(:summary,article_meta['summary'])
    game_article.store(:img,article_meta['image'])
    game_article.store(:published_at,article_meta['published_at'])
    game_article.store(:title,article_meta['title'])
    game_article.store(:news_source,article_meta['pulse_source']['name'])
    game_article.store(:url,article_meta['website']['url'])
    game_article
  end
  #TODO Refactor this for similar to the above
  def gameLatestNewsRequest(time)
    puts "Called to Latest Feed Request with parameter: " << DateTime.strptime(time.to_s,'%s').strftime("%A-%d-%b-%Y")
    request = buildRequest(GAME_ARTICLE_URI)
    request.body = "fields id,author,summary,title,image,published_at,pulse_source.name,website.url; where published_at > #{time};limit 12;"
    response = http_construct.request(request)
    result = JSON.parse(response.read_body)
    latest_news = []
    result.each do |article|
      latest_news << OpenStruct.new(gameArticleProcess(article))
    end
    latest_news
  end
  
  #Get Related News from multiple sources for a game
  def gameNewsFeedRequest(game_id)
    puts "Called to News Feed Request with parameter: " << game_id.to_s
    request = buildRequest(GAME_NEWS_GROUP_URI)
    request.body = "fields *; where game = #{game_id};"
    response = http_construct.request(request)
    result = JSON.parse(response.read_body)
    puts result
    article_ids = []
    
    if result.empty?
      nil
    else
      result.each do |rs|
        article_ids << rs["pulses"].join(",").to_i
      end
    end

    game_article_list = []
    article_ids.each do |id|
        game_article = gameArticleRequest(id)
        next if game_article.nil?
        game_article_list << game_article
    end
    game_article_list
  end
   
  def gameArticleRequest(id)
    puts "Called to Game Article Request with parameter: " << id.to_s
    request = Net::HTTP::Get.new(URI(GAME_ARTICLE_URI), {'user-key' => USERKEY})
    request.body = "fields id,author,summary,title,image,published_at,pulse_source.name,website.url; where id = #{id};"
    response = http_construct.request(request)
    game_article = nil
    
    if JSON.parse(response.read_body).empty?
      nil
    else
      article = JSON.parse(response.read_body).first
      #Constructing Article Hashes
      unless article.key?("website")
        nil
      else
        game_article = OpenStruct.new(gameArticleProcess(article))
      end
    end
    game_article
  end
 
  def platformCodeConvert(platform)
    puts "Call to platforms convert with #{platform}"
    platform_id = nil
    case platform 
      when 'PlayStation 4'
        platform_id = 48
      when 'Xbox One'
        platform_id = 49
      when 'PC (Microsoft Windows)'
        puts 'Most Popular PC Game'
        platform_id = 6
      when 'Nintendo Switch'
        puts 'Most Popular Switch Game'
        platform_id = 130
      when 'iOS'
        platform_id = 39
      #TODO Add more platforms  
      else
        puts "(#{platform}) is not a valid platform" #  & m =#{month} & y=#{year} 
    end
    platform_id
  end
  
  def gameRecentRelease(platform)
    puts "Called to Recent Released Game Request"
    request = buildRequest(RELEASE_URI)
    platform_id = platformCodeConvert(platform)
    # month = Time.now.month
    # year = Time.now.year
    
    #Return games released around 1 month
    request.body = "fields *,game.name; where date > #{3.month.ago.to_i} & date < #{Time.now.to_i}  & game.platforms = #{platform_id}; sort m desc; limit 20;"
    puts request.body
    response = http_construct.request(request)
    puts JSON.parse(response.read_body) 
    JSON.parse(response.read_body)
  end
  
  #This is to get the release date using GAME_URI instead of release date enpoint
  #This is a workaround I used for limiting the result of regions
  def gameAltRecentRelease(platform)
    puts "Called to Altenate Recent Released Game Request"
    request = buildRequest(GAME_URI)
    platform_id = platformCodeConvert(platform)
    request.body = "fields id,name,platforms.name,first_release_date; where first_release_date > #{1.month.ago.to_i} & first_release_date < #{Time.now.to_i} & platforms = {#{platform_id}}; limit 20;"
    puts request.body
    response = http_construct.request(request)
    puts JSON.parse(response.read_body) 
    JSON.parse(response.read_body)
  end
  
  #This will be used to get games that released base on a date.
  def gameReleaseRequest(time)
    # puts "Called to Recent Released Game Request"
    # request = buildRequest(GAME_URI)
    # platform_id = platformCodeConvert(platform)
    # request.body = "fields id,name,platforms.name,first_release_date; where first_release_date > #{1.month.ago.to_i} & first_release_date < #{Time.now.to_i} & platforms = {#{platform_id}}; limit 20;"
    # puts request.body
    # response = http_construct.request(request)
    # puts JSON.parse(response.read_body) 
    # JSON.parse(response.read_body)
  end
  
  
  def gamePopularUpcomingRelease
    puts "Called to Popular Upcoming Release game"
    request = buildRequest(GAME_URI)
    request.body = "fields *; where first_release_date > #{UNIX_TIME_NOW}; sort popularity desc; limit 25;"
    #request.body = "fields *; where first_release_date > #{UNIX_TIME_NOW} & hypes > 500; sort hypes desc;"

    response = http_construct.request(request)
    puts response.read_body
    result = JSON.parse(response.read_body)
    ids_array = []
    result.each do |x|
      ids_array << x["id"]
    end
    
    puts ids_array
    ids_array
  end
  
  def popularGamesByPlatform(platform)
    puts "Called to Popular Release by Platform"
    request = buildRequest(GAME_URI)
    #request.body = "fields *; where first_release_date > #{UNIX_TIME_NOW} & hypes > 500; sort hypes desc;"
    platform_id = platformCodeConvert(platform)
    platformCodeConvert(platform)
    
    request.body = "fields id,name,platforms.name; where platforms = {#{platform_id}}; sort popularity desc; limit 10;"
    puts request.body
    
    response = http_construct.request(request)
    puts response.read_body
    JSON.parse(response.read_body)
    # ids_array = []
    # result.each do |x|
    #   ids_array << x["id"]
    # end
    
    # puts ids_array
    # ids_array
  end
  
  def gameReleaseDateRequest(id)
    puts "Called to Release Date Request with parameter: "
    request = Net::HTTP::Get.new(URI(RELEASE_URI), {'user-key' => USERKEY})
    
    if id.nil?
      request.body = "fields *; where date > #{UNIX_TIME_NOW};"
    else
      request.body = "fields *; where game = #{id};"
    end
    
    response = http_construct.request(request)
    
    JSON.parse(response.read_body)
    #releaseTime = result.first['date']
    
    # result.each do |x|
    #   x['date'] = DateTime.strptime(x['date'].to_s,'%s').strftime("%A-%d-%b-%Y")
    # end
    # result
  end
      
  def gameCoverRequest(game_id)
      puts "Called to Game Cover Request with parameter: " << game_id.to_s
      request = Net::HTTP::Get.new(URI(COVER_URI), {'user-key' => USERKEY})
      #request.body = "fields name,summary; where id = #{gameID};";
      request.body = "fields url; where game = (#{game_id});"
      response = http_construct.request(request)
        
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
      response = http_construct.request(request)
      
      if JSON.parse(response.read_body).empty?
         ' '
        else
          result = JSON.parse(response.read_body)
          #puts result
          puts result
      end
  end

  #This is used to search for a specific game. 
  #Initially, this just a hardcoded string to return details of a game
  def gamesSearchRequest(game_string)
    puts "Called to Game Search Request with parameter: " << game_string
    request = Net::HTTP::Get.new(URI(GAME_URI), {'user-key' => USERKEY})
    #request.body = 'fields *; where name = "' << game_string << '";' QUERY FOR GAME_SEARCH_URI
    request.body  = 'search " '<< game_string << '";'
    puts request.body
    response = http_construct.request(request)
    #puts JSON.parse(response.read_body)
    result = JSON.parse(response.read_body)
    game_ids = []
    result.each do |x|
      game_ids << x["id"]
    end
    game_ids
  end
  #TODO - Handle empty image here
  def gameScreenshotRequest(game_id)
      puts "Called to Game Screenshots Request with parameter: " << game_id.to_s
      request = Net::HTTP::Get.new(URI(SCREENSHOTS_URI), {'user-key' => USERKEY})
      request.body = "fields *; where game = (#{game_id});"
      response = http_construct.request(request)
  
      if JSON.parse(response.read_body).empty?
          DUMMY_SCREENSHOT
        else
          result = JSON.parse(response.read_body)
          puts result
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
    response = http_construct.request(request)
    
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
  
  def gameCardProcess(game_detail)
      #TODO Refactor this. There is surely a better way to handle hash here...
      
      game_card = {:id =>nil,:name=>nil, :summary=> nil,:storyline => nil,:cover=>nil,:first_release_date=>nil,:popularity=>nil,:platform=>nil,:genres=>nil}
      
      game_id = game_detail['id']
      game_card.store(:id,game_id)
      game_name = game_detail['name']
      game_card.store(:name,game_name)
      
      game_storyline = game_detail['storyline']
      game_card.store(:storyline,game_storyline)
      
      if game_detail.key?("summary")
        game_summary = game_detail['summary']
        game_card.store(:summary,game_summary)
      else
        game_card.store(:summary,'NA')
      end
      game_cover = gameCoverRequest(game_id)
      game_card.store(:cover,game_cover)
      game_popularity = game_detail['popularity']
      game_card.store(:popularity,game_popularity)
    unless (game_detail["platforms"].nil? || game_detail["genres"].nil? || game_detail["first_release_date"].nil? )
      #TODO: Refactor this smell
      game_platform = []
      game_platform = game_detail["platforms"]
      game_card.store(:platform,game_platform)
      #LEGACY: Below was used when getting name from API
      # game_detail["platforms"].map{|x| x["name"]}.each do |name|
      #   game_platform << name
      # end
      
      #TODO: Inspecting... ['platforms', 'genres', 'first_release_date'].any? do |key| game_detail.key?(key) end
      
      game_genres = []
      game_genres = game_detail["genres"]
      #LEGACY: Below was used when getting name from API
      # game_genres = game_detail["genres"].map{|x| x["name"]}.join(',')
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
      puts "Array of Game Info"
      games_id_array[0..7].each do |x|
      game_detail = gamesRequest(x).first
      game_card = gameCardProcess(game_detail)
      game_card_list << game_card
      end
      game_card_list
    else 
      puts "Single Game Info"
      game_detail = gamesRequest(games_id_array).first
      game_card = gameCardProcess(game_detail)
      game_card
    end
  end

  def gamesPlatformRequest(id)
    request = Net::HTTP::Get.new(URI(PLATFORM_URI), {'user-key' => USERKEY})
    request.body = "fields *; where id = #{id};";
    response = http_construct.request(request)
    puts JSON.parse(response.read_body).first
    JSON.parse(response.read_body).first
  end
    
   # def gamesPlatformLogoRequest(logo_id)
  #   request = Net::HTTP::Get.new(URI(PLATFORM_LOGO), {'user-key' => USERKEY})
   
  #   # request.body = "fields alpha_channel,animated,height,image_id,url,width;";
  #   request.body = 'fields *; where image_id = ' << logo_id << ';';
  #   response = http_construct.request(request)
  #   result = JSON.parse(response.read_body)
  #   img = []
    
  #   result.each do |res|
  #     img << res["url"]
  #   end
  #   img
  # end
  
end