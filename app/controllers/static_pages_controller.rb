# frozen_string_literal: true

class StaticPagesController < ApplicationController
  # Content on home page
  def home
    game = Game.new
    # @upcoming_popular_games = game.fetchPopularUpcomingRelease[1..8]

    # TODO: Add sorting by created date here
    @all_posts = Post.all[0..10]
    
    @hotgames = game.fetchPopularUpcomingRelease
    data = ['PlayStation 4', 'PC (Microsoft Windows)', 'Nintendo Switch', 'Xbox One']
    # debugger
    @platforms_list = Platform.where('name IN (?)', data).pluck(:name)

    if params[:platform_name].nil?
    else
      @latest_games = game.fetchLatestRelease(params[:platform_name]) # .paginate(:page =>params[:page], :per_page => 5)
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

  def help; end

  def latest_release
    render ''
  end

  def about; end

  def contact; end

  def newsfeeds
    arc = GameArticle.new
    @news = nil
    # @gematsu_rss_feeds = FetchNewsFeedJob.perform_later('gematsu')
    # @gamespot_rss_feeds = FetchNewsFeedJob.perform_later('gamespot')
    # @pushsquare_rss_feeds = FetchNewsFeedJob.perform_later('pushsquare')
    @gematsu_rss_feeds    = arc.rssFeed('gematsu')
    @gamespot_rss_feeds   = arc.rssFeed('gamespot')
    @pushsquare_rss_feeds = arc.rssFeed('pushsquare')
    @ign_rss_feeds        = arc.rssFeed('ign')
    
    render 'news_feed'
  end
end
