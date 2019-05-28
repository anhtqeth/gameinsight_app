class StaticPagesController < ApplicationController
  include GamesApiModule
  def home
    
     feature_games_id = gamesSeriesRequest.first['games']
    
    # recent_release_id = []
    # @recent_release_date = []
    # gameReleaseDateRequest.each do |game|
    #   recent_release_id << game['game']
    #   @recent_release_date << game['date']
    # end
    # puts @recent_release_id
    # puts @recent_release_date
    if feature_games_id.nil?
       @game_card_list = []
    else
       @game_card_list = gamesListProcess(feature_games_id)
       puts @game_card_list
    end
    
    # @release_game_card_list = gamesListProcess(recent_release_id)
    # puts @release_game_card_list
    
    @dummy_game_card_list = [{:id=>2059, :name=>"Yakuza", :summary=>"Just as Kazuma, a former rising star in the Yakuza, emerges from prison after a murder cover-up, 10 billion yen vanishes from the Yakuza vault, forcing him once again into their brutal, lawless world. A mysterious young girl will lead Kazuma to the answers if he can keep her alive.", :cover=>"//images.igdb.com/igdb/image/upload/t_cover_big/e3cdy0d77eduopr5en37.jpg"}, {:id=>2060, :name=>"Yakuza 2", :summary=>"Yakuza 2 plunges you once more into the violent Japanese underworld. In intense brutal clashes with rival gangs, the police, and the Korean mafia, you will have opportunities to dole out more brutal punishment. As the heroic Kazuma Kiryu from the original Yakuza, explore Tokyo and now Osaka. Wander through the back alleys of Japan's underworld while trying to prevent an all-out gang war in over 16 complex, cinematic chapters written by Hase Seishu, the famous Japanese author who also wrote the first Yakuza. Endless conflicts and surprise plot twists will immerse you in a dark shadowy world where only the strongest will survive.", :cover=>"//images.igdb.com/igdb/image/upload/t_cover_big/ozhhq6bsu5elgkhbraoe.jpg"}, {:id=>2061, :name=>"Yakuza 3", :summary=>"Introducing the next cinematic chapter in the prestigious Yakuza series renowned for it's authentic, gritty and often violent look at modern Japan. Making its first appearance exclusively on the PlayStation 3 computer entertainment system, the rich story and vibrant world of Yakuza 3 lets players engage in intense brutal clashes within the streets of Okinawa, and the vibrant and often dangerous city of Tokyo where only the strongest will survive.", :cover=>"//images.igdb.com/igdb/image/upload/t_cover_big/amhmvuaybvl0epgcpfys.jpg"}, {:id=>2062, :name=>"Yakuza 4", :summary=>"Yakuza 4 is the fourth game in Sega's crime drama series, known as 'Ryu ga Gotoku' in Japan. As a first for the series, the story is split between the viewpoints of four different protagonists.", :cover=>"//images.igdb.com/igdb/image/upload/t_cover_big/udb2eilafrf5yujesuq8.jpg"}]
    #@game_card_list = @dummy_game_card_list
    #@dummy_feature_list = [{"id"=>244572, "game"=>55090, "height"=>720, "image_id"=>"iodd6zzceqq5jkufxpcz", "url"=>"//images.igdb.com/igdb/image/upload/t_screenshot_big/iodd6zzceqq5jkufxpcz.jpg", "width"=>1280},{"id"=>208211, "game"=>55090, "height"=>1080, "image_id"=>"wdsb42ukz39ywlzvhro4", "url"=>"//images.igdb.com/igdb/image/upload/t_screenshot_big/wdsb42ukz39ywlzvhro4.jpg", "width"=>1920},{"id"=>244573, "game"=>55090, "height"=>562, "image_id"=>"af8ueznswr8xpdkw9ukf", "url"=>"//images.igdb.com/igdb/image/upload/t_screenshot_big/af8ueznswr8xpdkw9ukf.jpg", "width"=>1000},{"id"=>208214, "game"=>55090, "height"=>1080, "image_id"=>"cxwpickwszhgdxvxdzzh", "url"=>"//images.igdb.com/igdb/image/upload/t_screenshot_big/cxwpickwszhgdxvxdzzh.jpg", "width"=>1920},{"id"=>208212, "game"=>55090, "height"=>1080, "image_id"=>"enex88ekm3se7a3vpqmp", "url"=>"//images.igdb.com/igdb/image/upload/t_screenshot_big/enex88ekm3se7a3vpqmp.jpg", "width"=>1920},{"id"=>208213, "game"=>55090, "height"=>1080, "image_id"=>"ywgv0zxrsocslwbkir8b", "url"=>"//images.igdb.com/igdb/image/upload/t_screenshot_big/ywgv0zxrsocslwbkir8b.jpg", "width"=>1920}]
    @dummy_feature_list = gameScreenshotRequest(55090)
    @dummy_game_details = [[{"id"=>55090, "age_ratings"=>[23132, 23133], "aggregated_rating"=>85.8181818181818, "aggregated_rating_count"=>12, "alternative_names"=>[23008, 23009], "category"=>0, "collection"=>380, "cover"=>34491, "created_at"=>1503619200, "external_games"=>[186682, 252367, 1184747, 1715944], "first_release_date"=>1512604800, "game_engines"=>[391], "game_modes"=>[1], "genres"=>[12, 31], "hypes"=>1, "involved_companies"=>[68666, 77486, 78907], "keywords"=>[939, 1033, 1669, 3234, 23149, 23150, 23151, 23152], "name"=>"Yakuza Kiwami 2", "platforms"=>[6, 48], "player_perspectives"=>[2], "popularity"=>7.881169054160125, "pulse_count"=>181, "rating"=>80.0, "rating_count"=>4, "release_dates"=>[110434, 149233, 156236, 168114], "screenshots"=>[208211, 208212, 208213, 208214, 244572, 244573], "similar_games"=>[16839, 28309, 30245, 36198, 55092, 78632, 80916, 96217, 101211, 106987], "slug"=>"yakuza-kiwami-2", "storyline"=>"A year after leaving his former life in the Tojo Clan behind, ex-yakuza Kazuma Kiryu is called back into action when the clan's Fifth Chairman, Yukio Terada, is murdered by assassins from a rival organization, the Omi Alliance. Returning to Kamurocho, Kiryu must find a new chairman for the Tojo Clan and prevent an all-out war between the Tojo and the Omi, bringing him into conflict with Ryuji Goda, the legendary \"Dragon Of Kansai\" of the Omi Alliance.", "summary"=>"Yakuza Kiwami 2 is a remake of Yakuza 2, and is an action-adventure game set in an open world environment and played from a third-person perspective. Combat is based on that previously seen in Yakuza 6. A new \"Majima Saga\" story scenario features recurring series anti-hero Goro Majima as a playable character.", "tags"=>[1, 268435468, 268435487, 536871851, 536871945, 536872581, 536874146, 536894061, 536894062, 536894063, 536894064], "themes"=>[1], "total_rating"=>82.9090909090909, "total_rating_count"=>16, "updated_at"=>1559001600, "url"=>"https://www.igdb.com/games/yakuza-kiwami-2", "videos"=>[16163, 18816, 20692, 21367, 21939, 26433], "websites"=>[75146, 88091, 104625]}]]
    
    
    @release_game_card_list = []
   
  end
  

  def help
    
  end

  def about
  end

  def contact
  
  end

end
