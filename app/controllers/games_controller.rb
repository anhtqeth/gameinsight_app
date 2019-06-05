class GamesController < ApplicationController
  include GamesApiModule
  
  #Render game detail url
  def show
  #   results = Rails.cache.fetch(cache_key) do  # You could use a unique URL as part of the cache key
  # # HTTP request
  # # Return results from processing the response
  #   end
    
  #   @hash = Rails.cache.fetch('something', expires_in: 15.minutes) do
  #   StatsClient.products
  #   end
    
    # @game_details = gamesRequest(params[:id])
    # @game_cover = gameCoverRequest(params[:id])
    
    @game_details = Rails.cache.fetch("#{params[:id]}/game_detail", expires_in: 1.month) do
      gamesRequest(params[:id])
    end
    
    @game_cover = Rails.cache.fetch("#{params[:id]}/game_cover", expires_in: 1.month) do
      gameCoverRequest(params[:id])
    end
    
    @game_screenshots = Rails.cache.fetch("#{params[:id]}/game_screenshots", expires_in: 1.month) do
        gameScreenshotRequest(params[:id])
    end
    
    #If There are no videos for the requested game, put up an example list
    @game_videos = Rails.cache.fetch("#{params[:id]}/game_videos", expires_in: 1.month) do
        gamesVideoRequest(params[:id])
    end
    
    @dummy_games_news = [{"id"=>285391, "author"=>"Sal Romano", "category"=>15, "created_at"=>1509667200, "ignored"=>false, "image"=>"https://gematsu.com/wp-content/uploads/2017/11/Yakuza-Kiwami-2_2017_11-03-17_001.jpg", "published_at"=>1509667200, "pulse_image"=>107374, "pulse_source"=>15, "summary"=>"Sega has updated the official website for Yakuza: Kiwami 2 with information and screenshots of the Sotenbori, Osaka area. Get the details below. ■ Adventure ◆ Sotenbori, Osaka Many New Stores Appear! Kansai’s No. 1 Entertainment District: Sotenbori, Osaka Kansai’s greatest entertainment district, Sotenbori is a restaurant district representative of Osaka, where people spend too …", "tags"=>[1, 268435468, 268435487, 536871851, 536871945, 536872581, 536874146, 536894061, 536894062, 536894063, 536894064, 805361458, 1073741826], "title"=>"Yakuza: Kiwami 2 details Sotenbori, Osaka", "uid"=>"100122401e1aa339f5e530f4832996a3", "updated_at"=>1509667200, "website"=>107041}], [{"id"=>107041, "trusted"=>false, "url"=>"https://gematsu.com/2017/11/yakuza-kiwami-2-details-sotenbori-osaka"}]
    
    # if gamesNewsFeedRequest(params[:id]).nil?
    #   @game_news = @dummy_games_new
    # else
    #   @game_news = gameNewsFeedRequest(params[:id])
    
    render 'games/show'
  end
  
  def find
    @dummy_game_ids = [76253, 134, 112, 135, 1254, 76843, 62352, 20734, 111750, 20022] #Devil May Cry
    
    if params[:name].blank?  
      flash[:info] = "Please specify a name"
      redirect_to(root_path)
    else
      game_id_result = gamesSearchRequest(params[:name])
      @game_card_result = gamesListProcess(game_id_result)
      render 'games/search_result'
    end
  end
  
  def update
    
  end
  
end
