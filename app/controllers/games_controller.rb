class GamesController < ApplicationController
  include GamesApiModule
  #Render game detail page
  def show
    @game_details = Rails.cache.fetch("#{params[:id]}/game_detail", expires_in: 1.month) do
          gamesRequest(params[:id])
    end
    game_collection_id = @game_details.first["collection"]
    
    if game_collection_id.nil?
      @game_card_carousel_list =  [{:id=>2059, :name=>"Yakuza", :summary=>"Just as Kazuma, a former rising star in the Yakuza, emerges from prison after a murder cover-up, 10 billion yen vanishes from the Yakuza vault, forcing him once again into their brutal, lawless world. A mysterious young girl will lead Kazuma to the answers if he can keep her alive.", :cover=>"//images.igdb.com/igdb/image/upload/t_cover_big/e3cdy0d77eduopr5en37.jpg"}, {:id=>2060, :name=>"Yakuza 2", :summary=>"Yakuza 2 plunges you once more into the violent Japanese underworld. In intense brutal clashes with rival gangs, the police, and the Korean mafia, you will have opportunities to dole out more brutal punishment. As the heroic Kazuma Kiryu from the original Yakuza, explore Tokyo and now Osaka. Wander through the back alleys of Japan's underworld while trying to prevent an all-out gang war in over 16 complex, cinematic chapters written by Hase Seishu, the famous Japanese author who also wrote the first Yakuza. Endless conflicts and surprise plot twists will immerse you in a dark shadowy world where only the strongest will survive.", :cover=>"//images.igdb.com/igdb/image/upload/t_cover_big/ozhhq6bsu5elgkhbraoe.jpg"}, {:id=>2061, :name=>"Yakuza 3", :summary=>"Introducing the next cinematic chapter in the prestigious Yakuza series renowned for it's authentic, gritty and often violent look at modern Japan. Making its first appearance exclusively on the PlayStation 3 computer entertainment system, the rich story and vibrant world of Yakuza 3 lets players engage in intense brutal clashes within the streets of Okinawa, and the vibrant and often dangerous city of Tokyo where only the strongest will survive.", :cover=>"//images.igdb.com/igdb/image/upload/t_cover_big/amhmvuaybvl0epgcpfys.jpg"}, {:id=>2062, :name=>"Yakuza 4", :summary=>"Yakuza 4 is the fourth game in Sega's crime drama series, known as 'Ryu ga Gotoku' in Japan. As a first for the series, the story is split between the viewpoints of four different protagonists.", :cover=>"//images.igdb.com/igdb/image/upload/t_cover_big/udb2eilafrf5yujesuq8.jpg"}]
    else
      game_series_ids = gamesSeriesRequest(game_collection_id)
      @game_card_carousel_list = Rails.cache.fetch("#{game_collection_id}/game_series", expires_in: 1.month) do
      gamesListProcess(game_series_ids)
      end
    end
    
    @game_newsfeed_list = gameNewsFeedRequest(params[:id])
    puts "GAME NEWSFEED IN CONTROLLER: " << @game_newsfeed_list.to_s
    # @ = Rails.cache.fetch("#{params[:id]}/game_newsfeed", expires_in: 1.month) do
          
    # end
    
    @game_cover = Rails.cache.fetch("#{params[:id]}/game_cover", expires_in: 1.month) do
      gameCoverRequest(params[:id])
    end
    
    @game_screenshots = Rails.cache.fetch("#{params[:id]}/game_screenshots", expires_in: 1.month) do
        gameScreenshotRequest(params[:id])
    end
    
    @game_videos = Rails.cache.fetch("#{params[:id]}/game_videos", expires_in: 1.month) do
        gamesVideoRequest(params[:id])
    end
    
    #dummy_game_ids = [2268, 2269, 2271, 5316, 6440, 7075, 9692, 18181]
    
    @dummy_games_news = [{"id"=>285391, "author"=>"Sal Romano", "category"=>15, "created_at"=>1509667200, "ignored"=>false, "image"=>"https://gematsu.com/wp-content/uploads/2017/11/Yakuza-Kiwami-2_2017_11-03-17_001.jpg", "published_at"=>1509667200, "pulse_image"=>107374, "pulse_source"=>15, "summary"=>"Sega has updated the official website for Yakuza: Kiwami 2 with information and screenshots of the Sotenbori, Osaka area. Get the details below. ■ Adventure ◆ Sotenbori, Osaka Many New Stores Appear! Kansai’s No. 1 Entertainment District: Sotenbori, Osaka Kansai’s greatest entertainment district, Sotenbori is a restaurant district representative of Osaka, where people spend too …", "tags"=>[1, 268435468, 268435487, 536871851, 536871945, 536872581, 536874146, 536894061, 536894062, 536894063, 536894064, 805361458, 1073741826], "title"=>"Yakuza: Kiwami 2 details Sotenbori, Osaka", "uid"=>"100122401e1aa339f5e530f4832996a3", "updated_at"=>1509667200, "website"=>107041}], [{"id"=>107041, "trusted"=>false, "url"=>"https://gematsu.com/2017/11/yakuza-kiwami-2-details-sotenbori-osaka"}]
    
    render 'games/game_detail'
  end
  
  def find
    @dummy_game_ids = [76253, 134, 112, 135, 1254, 76843, 62352, 20734, 111750, 20022] #Devil May Cry
    
    if params[:name].blank?  
      flash[:info] = "Please specify a name"
      redirect_to(root_path)
    else
      game_id_result = Rails.cache.fetch("#{params[:name]}/game_name_search", expires_in: 1.month) do
        gamesSearchRequest(params[:name])
      end
      @game_card_result = gamesListProcess(game_id_result)
      render 'games/search_result'
    end
  end
  
  def update
    
  end
  
end
