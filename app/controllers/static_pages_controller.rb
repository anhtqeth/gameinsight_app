class StaticPagesController < ApplicationController
  include GamesApiModule
  def home
    #TODO: Remove Dummy list
    game = Game.new
    @dummy_game_card_list = [{:id=>2059, :name=>"Yakuza", :summary=>"Just as Kazuma, a former rising star in the Yakuza, emerges from prison after a murder cover-up, 10 billion yen vanishes from the Yakuza vault, forcing him once again into their brutal, lawless world. A mysterious young girl will lead Kazuma to the answers if he can keep her alive.", :cover=>"//images.igdb.com/igdb/image/upload/t_cover_big/e3cdy0d77eduopr5en37.jpg"}, {:id=>2060, :name=>"Yakuza 2", :summary=>"Yakuza 2 plunges you once more into the violent Japanese underworld. In intense brutal clashes with rival gangs, the police, and the Korean mafia, you will have opportunities to dole out more brutal punishment. As the heroic Kazuma Kiryu from the original Yakuza, explore Tokyo and now Osaka. Wander through the back alleys of Japan's underworld while trying to prevent an all-out gang war in over 16 complex, cinematic chapters written by Hase Seishu, the famous Japanese author who also wrote the first Yakuza. Endless conflicts and surprise plot twists will immerse you in a dark shadowy world where only the strongest will survive.", :cover=>"//images.igdb.com/igdb/image/upload/t_cover_big/ozhhq6bsu5elgkhbraoe.jpg"}, {:id=>2061, :name=>"Yakuza 3", :summary=>"Introducing the next cinematic chapter in the prestigious Yakuza series renowned for it's authentic, gritty and often violent look at modern Japan. Making its first appearance exclusively on the PlayStation 3 computer entertainment system, the rich story and vibrant world of Yakuza 3 lets players engage in intense brutal clashes within the streets of Okinawa, and the vibrant and often dangerous city of Tokyo where only the strongest will survive.", :cover=>"//images.igdb.com/igdb/image/upload/t_cover_big/amhmvuaybvl0epgcpfys.jpg"}, {:id=>2062, :name=>"Yakuza 4", :summary=>"Yakuza 4 is the fourth game in Sega's crime drama series, known as 'Ryu ga Gotoku' in Japan. As a first for the series, the story is split between the viewpoints of four different protagonists.", :cover=>"//images.igdb.com/igdb/image/upload/t_cover_big/udb2eilafrf5yujesuq8.jpg"}]
    @game_card_list = @dummy_game_card_list
    @dummy_feature_list = [{"id"=>305890, "alpha_channel"=>false, "animated"=>false, "game"=>113344, "height"=>2160, "image_id"=>"sc6k0y", "url"=>"//images.igdb.com/igdb/image/upload/t_1080p/sc6k0y.jpg", "width"=>3840}, {"id"=>305892, "alpha_channel"=>false, "animated"=>false, "game"=>113344, "height"=>2160, "image_id"=>"sc6k10", "url"=>"//images.igdb.com/igdb/image/upload/t_1080p/sc6k10.jpg", "width"=>3840}, {"id"=>305893, "alpha_channel"=>false, "animated"=>false, "game"=>113344, "height"=>2160, "image_id"=>"sc6k11", "url"=>"//images.igdb.com/igdb/image/upload/t_1080p/sc6k11.jpg", "width"=>3840}, {"id"=>305895, "alpha_channel"=>false, "animated"=>false, "game"=>113344, "height"=>1080, "image_id"=>"sc6k13", "url"=>"//images.igdb.com/igdb/image/upload/t_1080p/sc6k13.jpg", "width"=>1920}, {"id"=>305894, "alpha_channel"=>false, "animated"=>false, "game"=>113344, "height"=>1080, "image_id"=>"sc6k12", "url"=>"//images.igdb.com/igdb/image/upload/t_1080p/sc6k12.jpg", "width"=>1920}, {"id"=>305898, "alpha_channel"=>false, "animated"=>false, "game"=>113344, "height"=>2160, "image_id"=>"sc6k16", "url"=>"//images.igdb.com/igdb/image/upload/t_1080p/sc6k16.jpg", "width"=>3840}, {"id"=>305899, "alpha_channel"=>false, "animated"=>false, "game"=>113344, "height"=>2160, "image_id"=>"sc6k17", "url"=>"//images.igdb.com/igdb/image/upload/t_1080p/sc6k17.jpg", "width"=>3840}, {"id"=>305900, "alpha_channel"=>false, "animated"=>false, "game"=>113344, "height"=>2160, "image_id"=>"sc6k18", "url"=>"//images.igdb.com/igdb/image/upload/t_1080p/sc6k18.jpg", "width"=>3840}, {"id"=>305889, "alpha_channel"=>false, "animated"=>false, "game"=>113344, "height"=>1080, "image_id"=>"sc6k0x", "url"=>"//images.igdb.com/igdb/image/upload/t_1080p/sc6k0x.jpg", "width"=>1920}, {"id"=>305891, "alpha_channel"=>false, "animated"=>false, "game"=>113344, "height"=>2160, "image_id"=>"sc6k0z", "url"=>"//images.igdb.com/igdb/image/upload/t_1080p/sc6k0z.jpg", "width"=>3840}]
    #[{"id"=>244572, "game"=>55090, "height"=>720, "image_id"=>"iodd6zzceqq5jkufxpcz", "url"=>"//images.igdb.com/igdb/image/upload/t_screenshot_big/iodd6zzceqq5jkufxpcz.jpg", "width"=>1280},{"id"=>208211, "game"=>55090, "height"=>1080, "image_id"=>"wdsb42ukz39ywlzvhro4", "url"=>"//images.igdb.com/igdb/image/upload/t_screenshot_big/wdsb42ukz39ywlzvhro4.jpg", "width"=>1920},{"id"=>244573, "game"=>55090, "height"=>562, "image_id"=>"af8ueznswr8xpdkw9ukf", "url"=>"//images.igdb.com/igdb/image/upload/t_screenshot_big/af8ueznswr8xpdkw9ukf.jpg", "width"=>1000},{"id"=>208214, "game"=>55090, "height"=>1080, "image_id"=>"cxwpickwszhgdxvxdzzh", "url"=>"//images.igdb.com/igdb/image/upload/t_screenshot_big/cxwpickwszhgdxvxdzzh.jpg", "width"=>1920},{"id"=>208212, "game"=>55090, "height"=>1080, "image_id"=>"enex88ekm3se7a3vpqmp", "url"=>"//images.igdb.com/igdb/image/upload/t_screenshot_big/enex88ekm3se7a3vpqmp.jpg", "width"=>1920},{"id"=>208213, "game"=>55090, "height"=>1080, "image_id"=>"ywgv0zxrsocslwbkir8b", "url"=>"//images.igdb.com/igdb/image/upload/t_screenshot_big/ywgv0zxrsocslwbkir8b.jpg", "width"=>1920}]
    #@dummy_feature_list = gameScreenshotRequest(55090)
    @dummy_game_details = [[{"id"=>55090, "age_ratings"=>[23132, 23133], "aggregated_rating"=>85.8181818181818, "aggregated_rating_count"=>12, "alternative_names"=>[23008, 23009], "category"=>0, "collection"=>380, "cover"=>34491, "created_at"=>1503619200, "external_games"=>[186682, 252367, 1184747, 1715944], "first_release_date"=>1512604800, "game_engines"=>[391], "game_modes"=>[1], "genres"=>[12, 31], "hypes"=>1, "involved_companies"=>[68666, 77486, 78907], "keywords"=>[939, 1033, 1669, 3234, 23149, 23150, 23151, 23152], "name"=>"Yakuza Kiwami 2", "platforms"=>[6, 48], "player_perspectives"=>[2], "popularity"=>7.881169054160125, "pulse_count"=>181, "rating"=>80.0, "rating_count"=>4, "release_dates"=>[110434, 149233, 156236, 168114], "screenshots"=>[208211, 208212, 208213, 208214, 244572, 244573], "similar_games"=>[16839, 28309, 30245, 36198, 55092, 78632, 80916, 96217, 101211, 106987], "slug"=>"yakuza-kiwami-2", "storyline"=>"A year after leaving his former life in the Tojo Clan behind, ex-yakuza Kazuma Kiryu is called back into action when the clan's Fifth Chairman, Yukio Terada, is murdered by assassins from a rival organization, the Omi Alliance. Returning to Kamurocho, Kiryu must find a new chairman for the Tojo Clan and prevent an all-out war between the Tojo and the Omi, bringing him into conflict with Ryuji Goda, the legendary \"Dragon Of Kansai\" of the Omi Alliance.", "summary"=>"Yakuza Kiwami 2 is a remake of Yakuza 2, and is an action-adventure game set in an open world environment and played from a third-person perspective. Combat is based on that previously seen in Yakuza 6. A new \"Majima Saga\" story scenario features recurring series anti-hero Goro Majima as a playable character.", "tags"=>[1, 268435468, 268435487, 536871851, 536871945, 536872581, 536874146, 536894061, 536894062, 536894063, 536894064], "themes"=>[1], "total_rating"=>82.9090909090909, "total_rating_count"=>16, "updated_at"=>1559001600, "url"=>"https://www.igdb.com/games/yakuza-kiwami-2", "videos"=>[16163, 18816, 20692, 21367, 21939, 26433], "websites"=>[75146, 88091, 104625]}]]
    # @upcoming_popular_games = Rails.cache.fetch("popularity/games", expires_in: 15.days) do
    #   gamesListProcess(gamePopularUpcomingRelease)
      
    # end
    @upcoming_popular_games = game.fetchPopularUpcomingRelease[1..8]
    
    
    #Currently set in controller, better if user can pick this from the view. Will change in 0.3
    time = (Time.current - 6.days).to_time.to_i
    game_article = GameArticle.new
    
    @latest_newsfeed = game_article.fetchLatestNews(time)
    
    #TODO - Removing the platofmr list later on
    data = ['PlayStation 4','PC (Microsoft Windows)','Nintendo Switch','Xbox One']
    @platforms_list = Platform.where("name IN (?)",data).pluck(:name)
    
    if params[:platform_name].nil?
      puts params[:platform_name]
    else
      puts params[:platform_name]
      #latest_games_ids = gameAltRecentRelease(params[:platform_name]).each.map{|x| x["game"]["id"]}.map.to_a
      # latest_games_ids = gameAltRecentRelease(params[:platform_name]).each.map{|x| x["id"]}.map.to_a
      # @latest_games = gamesListProcess(latest_games_ids)
     
      @latest_games = game.fetchLatestRelease(params[:platform_name])
    end
    
    respond_to do |format|
      format.html
      format.js
    end
    
    @nintendo_switch_list = game.fetchPopularGamebyPlatform('Nintendo Switch')
    @ps4_list = game.fetchPopularGamebyPlatform('PlayStation 4')
    @xbox_list = game.fetchPopularGamebyPlatform('Xbox One')
    @pc_list = game.fetchPopularGamebyPlatform('PC (Microsoft Windows)')
    
  end

  def help
    
  end

  def about
  end

  def contact
  
  end

end
