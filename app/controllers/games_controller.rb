class GamesController < ApplicationController
  #Show game detail page
  #TODO: Move save logic to model. Just like article
  #TODO: This is a fat controller. 
  #TODO: Implement caching 
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
    game_dev = InvolvedCompany.where(game_id: game.id).publisher.take
    game_pub = InvolvedCompany.where(game_id: game.id).developer.take
    
    game_dev.nil? ? game_dev = Company.new.saveAPIData(game.external_id,'Developer') : game_dev = game_dev.company
    game_pub.nil? ? game_pub = Company.new.saveAPIData(game.external_id,'Publisher') : game_pub = game_pub.company
    
    @game_publisher = game_dev
    @game_developer = game_pub
    
    render 'games/game_detail'
  end
  
  #TODO - Add more way to search, currently search by name.
  def find
    #TODO - Seach game from api as well.
    if params[:name].blank?  
      flash[:info] = "Please specify a name"
      redirect_to(root_path)
    else
      result = Game.where("name LIKE ?","%#{params[:name]}%")
      #TODO - Probably check empty here and call API?
      @game_card_result = result.paginate(:page =>params[:page], :per_page => 4)
      #@game_card_result = gamesListProcess(game_id_result).paginate(:page =>params[:page], :per_page => 4)
      render 'games/search_result'
    end
    
  end
  
  def discover
    game = Game.new
    @hotgames = game.fetchPopularUpcomingRelease
    @genres = GameGenre.all
    
    # @game_by_genres = Game.where
    # @game_by_platform
    # @just_released
    
    render 'games/game_discover'
  end
  
  def releases
    
    
  end
  
  def update
    #Should show all current game detail in db 
    #Should show assocciated screenshots and videos for update
  
  end
  
end
