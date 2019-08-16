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
    
    if game.game_collection.nil?
      game_collection = GameCollection.new
      #TODO: THere is a bug when API request no data for serie (NEW IP)
      if game_collection.saveAPIData(game.external_id).nil?
        @game_card_carousel_list = nil
      else
        @game_card_carousel_list = game.game_collection.games
        @size = @game_card_carousel_list.size/2 #TODO - Move this to helper
      end
    else
      @game_card_carousel_list = game.game_collection.games.order('first_release_date DESC')[0..10]
      @size = @game_card_carousel_list.size/2
    end
    #19164
     #gc = GameArticleCollection.new
     #gc.saveAPIData(19164)
    
    if game.game_article_collection.empty?
      game_article_collection = GameArticleCollection.new
      game_article_collection.saveAPIData(game.external_id)
      game_article_collection = GameArticleCollection.where(game_id: game.id).take
      @game_newsfeed_list = game_article_collection.game_articles
    else
      game_article_collection = GameArticleCollection.where(game_id: game.id).take
      @game_newsfeed_list = game_article_collection.game_articles
    end
    
    # @game_newsfeed_list = Rails.cache.fetch("#{params[:id]}/game_newfeed", expires_in: 1.month) do
    #   gameNewsFeedRequest(game.external_id)
    # end
    
    
    @game_publisher = gameCompaniesRequest(game.external_id,'Publisher')
    @game_developer = gameCompaniesRequest(game.external_id,'Developer')
    
   
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
  
  def discover
    
    
    render 'games/game_discover'
  end
  
  def update
    #Should show all current game detail in db 
    #Should show assocciated screenshots and videos for update
  
  end
  
end
