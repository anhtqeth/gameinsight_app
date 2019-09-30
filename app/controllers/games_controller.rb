class GamesController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update]
  #Show game detail page
  #TODO: Move save logic to model. Just like article
  #TODO: This is a fat controller. 
  #TODO: Implement caching 
  #TODO: Add more feature to controller
    
  def index
    if params[:search]
      puts 'DEBUGGING SEARCH'
      puts params[:search]
      @search_result = Game.search_by_name(params[:search]).order(:name).paginate(:page =>params[:page], :per_page => 15)
      
      respond_to do |format|
        format.js { render partial: 'search-results'}
      end
      
    else  
      @games = Game.all.order(:name).paginate(:page =>params[:page], :per_page => 15)
      #@game_card_result = result
    end
  end
  
  def destroy
    Game.friendly.find(params[:id]).destroy
    flash.now[:success] = "Game deleted!"
    redirect_back(fallback_location: root_path)
  end
  
  def edit
    @game = Game.friendly.find(params[:id])
    @screenshot = Screenshot.new
    @video = GameVideo.new
    @game_article = GameArticle.new
    
    if @game.involved_companies.publisher.nil? 
      @pub_company = InvolvedCompany.new
    else
      @pub_company = @game.involved_companies.publisher
    end
    
    if @game.involved_companies.developer.nil? 
      @dev_company = InvolvedCompany.new
    else
      @dev_company = @game.involved_companies.developer
    end
   
    
   # game = Game.find_by(external_id: 103329)

    @publisher = Game.publisher(@game)
    @developer = Game.developer(@game)
    
    @genres = @game.game_genres.map{|x| x.name}.join(',')
    @platform = @game.platforms.map{|x| x.name}.join(',')
    
    puts '@game ID'
    puts @game.id
    
    game_article_collection = GameArticleCollection.where(game_id: @game.id).take
    game_article_collection.nil? ? @game_articles = nil : @game_articles = game_article_collection.game_articles
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
    game = nil
    if Game.friendly.find_by(slug: params[:id]).nil? && Game.find_by_external_id(params[:id]).nil?
      game = Game.new
      @game_details = game.saveAPIData(params[:id])
      @game_videos = @game_details.game_videos
      @game_screenshots = @game_details.screenshots
      game = Game.find_by(external_id: params[:id])
    else 
      game = (params[:id].to_i != 0) ? Game.find_by_external_id(params[:id]) : Game.friendly.find_by(slug: params[:id])
      
      @game_details = game
      @game_videos = game.game_videos
      @game_screenshots = game.screenshots
    end
   
    puts 'DEBUG --- GAME CONTROLLER'
    puts game
    puts game.external_id
    
    #TODO - Handle this collection. Currently fecth all data and save. 
    #This reduce performance by 10x
   
    if game.game_collection.nil?
       FetchGamesCollectionJob.perform_later(game)
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
    
    @game_publisher = Game.developer(game)
    @game_developer = Game.publisher(game)
    
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
    
    def screenshot_params
      params.require(:screenshot).permit(:url,:width,:height,:game_id)
    end
    
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
end
