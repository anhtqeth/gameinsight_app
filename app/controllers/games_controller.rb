class GamesController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update]
  #Show game detail page
  #TODO: Move save logic to model. Just like article
  #TODO: This is a fat controller. 
  #TODO: Implement caching 
  #TODO: Add more feature to controller
  #TODO: 
  
    
  def index
    @games = Game.all.order(:name).paginate(:page =>params[:page], :per_page => 15)
    #@game_card_result = result
    
  end
  
  def destroy
    Game.friendly.find(params[:id]).destroy
    flash.now[:success] = "Game deleted!"
    redirect_back(fallback_location: root_path)
  end
  
  def edit
    @game = Game.friendly.find(params[:id])
  end

  def update
    #Should show assocciated screenshots and videos for update
    @game = Game.friendly.find(params[:id])
    if @game.update_attributes(game_params)
      flash.now[:success] = "Game detail updated"
      redirect_to @game
    else
      render 'edit'
    end
  end
 
  def show
    #If this game is not in db, save it. 
    game = nil
    if Game.friendly.find_by(slug: params[:id]).nil?
      game = Game.new
      @game_details = game.saveAPIData(params[:id])
      @game_videos = @game_details.game_videos
      @game_screenshots = @game_details.screenshots
      game = Game.find_by(external_id: params[:id])
    else
      game =  Game.friendly.find(params[:id])
      @game_details = Game.friendly.find(params[:id])
      @game_videos = @game_details.game_videos
      @game_screenshots = @game_details.screenshots
    end
   
    puts 'DEBUG --- GAME CONTROLLER'
    puts game
    puts game.external_id
    
    #TODO - Handle this collection. Currently fecth all data and save. This reduce performance by 10x
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
      #TODO - Move this to games.rb
      game = Game.new
      #result = game.findGames(params[:name])
      
      @rs = game.findGames(params[:name])[0]
      puts 'DEBUG --- GAME CONTROLLER'
      puts 'Result from own model'
      puts @rs.count
      @api_rs = game.findGames(params[:name])[1]
      puts 'Result from api'
      puts @api_rs.count
     
      #@game_card_result = result.paginate(:page =>params[:page], :per_page => 5)
      #@game_card_result = result.paginate(:page =>params[:page], :per_page => 5)
      render 'games/search_result'
    end
    
  end
  
  def discover
    game = Game.new
    @hotgames = game.fetchPopularUpcomingRelease
    @genres = GameGenre.all
   
    render 'games/game_discover'
  end
  
  def releases
    
    
  end

  private 
    def game_params
      params.require(:game).permit(:cover, :name,
                                   :slug,:summary, :storyline, :first_release_date)
    end
    
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
end
