class GamesController < ApplicationController
  include GamesApiModule
  #Render game detail page
  def show
    
    @game_details = Rails.cache.fetch("#{params[:id]}/game_detail", expires_in: 1.month) do
        gamesListProcess(params[:id])
    end
    
    game_collection_id = gamesRequest(params[:id]).first["collection"]
    
    if game_collection_id.nil?
      @game_card_carousel_list =  [{:id=>2059, :name=>"Yakuza", :summary=>"Just as Kazuma, a former rising star in the Yakuza, emerges from prison after a murder cover-up, 10 billion yen vanishes from the Yakuza vault, forcing him once again into their brutal, lawless world. A mysterious young girl will lead Kazuma to the answers if he can keep her alive.", :cover=>"//images.igdb.com/igdb/image/upload/t_cover_big/e3cdy0d77eduopr5en37.jpg"}, {:id=>2060, :name=>"Yakuza 2", :summary=>"Yakuza 2 plunges you once more into the violent Japanese underworld. In intense brutal clashes with rival gangs, the police, and the Korean mafia, you will have opportunities to dole out more brutal punishment. As the heroic Kazuma Kiryu from the original Yakuza, explore Tokyo and now Osaka. Wander through the back alleys of Japan's underworld while trying to prevent an all-out gang war in over 16 complex, cinematic chapters written by Hase Seishu, the famous Japanese author who also wrote the first Yakuza. Endless conflicts and surprise plot twists will immerse you in a dark shadowy world where only the strongest will survive.", :cover=>"//images.igdb.com/igdb/image/upload/t_cover_big/ozhhq6bsu5elgkhbraoe.jpg"}, {:id=>2061, :name=>"Yakuza 3", :summary=>"Introducing the next cinematic chapter in the prestigious Yakuza series renowned for it's authentic, gritty and often violent look at modern Japan. Making its first appearance exclusively on the PlayStation 3 computer entertainment system, the rich story and vibrant world of Yakuza 3 lets players engage in intense brutal clashes within the streets of Okinawa, and the vibrant and often dangerous city of Tokyo where only the strongest will survive.", :cover=>"//images.igdb.com/igdb/image/upload/t_cover_big/amhmvuaybvl0epgcpfys.jpg"}, {:id=>2062, :name=>"Yakuza 4", :summary=>"Yakuza 4 is the fourth game in Sega's crime drama series, known as 'Ryu ga Gotoku' in Japan. As a first for the series, the story is split between the viewpoints of four different protagonists.", :cover=>"//images.igdb.com/igdb/image/upload/t_cover_big/udb2eilafrf5yujesuq8.jpg"}]
      @size = @game_card_carousel_list.size/2
    else
      game_series_ids = gamesSeriesRequest(game_collection_id)
      @game_card_carousel_list = Rails.cache.fetch("#{game_collection_id}/game_series", expires_in: 1.month) do
        gamesListProcess(game_series_ids)
      end
      @size = @game_card_carousel_list.size/2
    end
    
    @game_newsfeed_list = Rails.cache.fetch("#{params[:id]}/game_newfeed", expires_in: 1.month) do
          gameNewsFeedRequest(params[:id])
    end
    
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
      @game_card_result = gamesListProcess(game_id_result).paginate(:page =>params[:page], :per_page => 4)   
      render 'games/search_result'
    end
  end
  
  def update
    
  end
  
end
