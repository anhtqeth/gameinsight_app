class GamesController < ApplicationController
  include GamesApiModule
  
  #Render game detail url
  def show
    @game_details = gamesRequest(params[:id])
    @game_cover = gameCoverRequest(params[:id])
    
    if gameScreenshotRequest(params[:id]).empty?
      @game_screenshots = [{"id"=>244572, "game"=>55090, "height"=>720, "image_id"=>"iodd6zzceqq5jkufxpcz", "url"=>"//images.igdb.com/igdb/image/upload/t_1080p/iodd6zzceqq5jkufxpcz.jpg", "width"=>1280}, {"id"=>208211, "game"=>55090, "height"=>1080, "image_id"=>"wdsb42ukz39ywlzvhro4", "url"=>"//images.igdb.com/igdb/image/upload/t_1080p/wdsb42ukz39ywlzvhro4.jpg", "width"=>1920}, {"id"=>244573, "game"=>55090, "height"=>562, "image_id"=>"af8ueznswr8xpdkw9ukf", "url"=>"//images.igdb.com/igdb/image/upload/t_1080p/af8ueznswr8xpdkw9ukf.jpg", "width"=>1000}, {"id"=>208214, "game"=>55090, "height"=>1080, "image_id"=>"cxwpickwszhgdxvxdzzh", "url"=>"//images.igdb.com/igdb/image/upload/t_1080p/cxwpickwszhgdxvxdzzh.jpg", "width"=>1920}, {"id"=>208212, "game"=>55090, "height"=>1080, "image_id"=>"enex88ekm3se7a3vpqmp", "url"=>"//images.igdb.com/igdb/image/upload/t_1080p/enex88ekm3se7a3vpqmp.jpg", "width"=>1920}, {"id"=>208213, "game"=>55090, "height"=>1080, "image_id"=>"ywgv0zxrsocslwbkir8b", "url"=>"//images.igdb.com/igdb/image/upload/t_1080p/ywgv0zxrsocslwbkir8b.jpg", "width"=>1920}]
      else
      @game_screenshots = gameScreenshotRequest(params[:id])
    end
    
    #If There are no videos for the requested game, put up an example list
    if gamesVideoRequest(params[:id]).empty?
      @game_videos = ["https://www.youtube.com/embed/LVIdmEfiFCk","https://www.youtube.com/embed/OAQm-EzbaHM"]
    else
      @game_videos = gamesVideoRequest(params[:id])
    end
    
    @dummy_games_news = [{"id"=>285391, "author"=>"Sal Romano", "category"=>15, "created_at"=>1509667200, "ignored"=>false, "image"=>"https://gematsu.com/wp-content/uploads/2017/11/Yakuza-Kiwami-2_2017_11-03-17_001.jpg", "published_at"=>1509667200, "pulse_image"=>107374, "pulse_source"=>15, "summary"=>"Sega has updated the official website for Yakuza: Kiwami 2 with information and screenshots of the Sotenbori, Osaka area. Get the details below. ■ Adventure ◆ Sotenbori, Osaka Many New Stores Appear! Kansai’s No. 1 Entertainment District: Sotenbori, Osaka Kansai’s greatest entertainment district, Sotenbori is a restaurant district representative of Osaka, where people spend too …", "tags"=>[1, 268435468, 268435487, 536871851, 536871945, 536872581, 536874146, 536894061, 536894062, 536894063, 536894064, 805361458, 1073741826], "title"=>"Yakuza: Kiwami 2 details Sotenbori, Osaka", "uid"=>"100122401e1aa339f5e530f4832996a3", "updated_at"=>1509667200, "website"=>107041}], [{"id"=>107041, "trusted"=>false, "url"=>"https://gematsu.com/2017/11/yakuza-kiwami-2-details-sotenbori-osaka"}]
    
    # if gamesNewsFeedRequest(params[:id]).nil?
    #   @game_news = @dummy_games_new
    # else
    #   @game_news = gameNewsFeedRequest(params[:id])
    
    render 'games/show'
  end

  def update
    
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
  
end
