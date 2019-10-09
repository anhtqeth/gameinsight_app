class StaticPagesController < ApplicationController
  #Content on home page
  def home
    game = Game.new
    @upcoming_popular_games = game.fetchPopularUpcomingRelease[1..8]
   
    #TODO Add sorting by created date here
    @all_posts = Post.all[0..10]
    
    #TODO- This is a compensation for the lack of newsfeed in 0.9 will be removed
    @hotgames = game.fetchPopularUpcomingRelease
    
    #TODO - Implemented your own
    #Currently set in controller, better if user can pick this from the view. Will change in 0.3
    # time = (Time.current - 6.days).to_time.to_i
    # game_article = GameArticle.new
    
    # @latest_newsfeed = game_article.fetchLatestNews(time)
    
    data = ['PlayStation 4','PC (Microsoft Windows)','Nintendo Switch','Xbox One']
    @platforms_list = Platform.where("name IN (?)",data).pluck(:name)
    
    if params[:platform_name].nil?
    else
      @latest_games = game.fetchLatestRelease(params[:platform_name]) #.paginate(:page =>params[:page], :per_page => 5)
    end
    respond_to do |format|
      format.html
      format.js
    end
    
    @nintendo_switch_list = game.fetchPopularGamebyPlatform('Nintendo Switch')
    @ps4_list = game.fetchPopularGamebyPlatform('PlayStation 4')
    @xbox_list = game.fetchPopularGamebyPlatform('Xbox One')
    @pc_list = game.fetchPopularGamebyPlatform('PC (Microsoft Windows)')
    
  end

  def help
    
  end
  
  def latest_release
    
    
    render ''
  end

  def about
    
  end

  def contact
  
  end
  
  def newsfeeds
    arc = GameArticle.new
    @rss_feeds = arc.rssFeed('gamespot')
    
    render 'news_feed'
  end

end
