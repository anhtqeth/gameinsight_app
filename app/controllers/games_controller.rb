class GamesController < ApplicationController
  #Show game detail page
  #TODO: Move save logic to model. Just like article
  def show
    #If this game is not in db, save it. 
    game =  Game.friendly.find(params[:id])
    
    if Game.friendly.find(params[:id])
      @game_details = Game.friendly.find(params[:id])
      @game_videos = @game_details.game_videos
      @game_screenshots = @game_details.screenshots
    else
      game = Game.new
      @game_details = game.saveAPIData(params[:id])
      @game_videos = @game_details.game_videos
      @game_screenshots = @game_details.screenshots
    end
    
    @game_publisher = gameCompaniesRequest(game.external_id,'Publisher')
    @game_developer = gameCompaniesRequest(game.external_id,'Developer')
    
    #TODO: Move this to Model
    if game.game_collection.nil?
      game_collection = GameCollection.new
      game_collection.saveAPIData(game.external_id)
      @game_card_carousel_list = game.game_collection.games
    else
      @game_card_carousel_list = game.game_collection.games.order('first_release_date DESC')[0..10]
    end
    
    # game_collection_id = gamesRequest(game.external_id).first["collection"]
      
    # if game_collection_id.nil?
    #   nil
    # else
    #   game_series_ids = gamesSeriesRequest(game_collection_id)
    #   @game_card_carousel_list = Rails.cache.fetch("#{game_collection_id}/game_series", expires_in: 1.month) do
    #   gamesListProcess(game_series_ids)
    # end
    #   @size = @game_card_carousel_list.size/2
    # end
      
    @game_newsfeed_list = Rails.cache.fetch("#{params[:id]}/game_newfeed", expires_in: 1.month) do
      gameNewsFeedRequest(game.external_id)
    end
    
    @game_newsfeed_list = @game_newsfeed_list.sort_by{|e| -e[:created_at]}
    
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
    #Should show all current game detail in db 
    #Should show assocciated screenshots and videos for update
  
  end
  
end
