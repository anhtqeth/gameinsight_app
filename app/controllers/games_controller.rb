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
