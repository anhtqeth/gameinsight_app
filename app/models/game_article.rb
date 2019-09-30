require 'rss'
require 'open-uri'
class GameArticle < ApplicationRecord
  
  validates :url,:title,:news_source,:publish_at,  presence: true
  belongs_to :game_article_collection,  optional: true
  
  
  #HIGH PROFILE FEED
  GAMESPOT_NEWS_RSS_FEED = 'https://www.gamespot.com/feeds/news/'
  IGN_NEWS_RSS = 'http://feeds.ign.com/ign/news'
  GEMATSU_RSS = 'https://gematsu.com/feed'
  DESTRUCTOID_RSS  = 'https://www.destructoid.com/index.phtml?t=ps4&mode=atom'
  PUSHSQUARE_RSS = 'http://www.pushsquare.com/feeds/latest'
  #Need to pick one
  EUROGAMER_RSS = 'https://www.eurogamer.net/rss'
  
  #OTHER PROFILE
  PUREPS_RSS = 'https://pureplaystation.com/feed/'
  SILICONERA_RSS = 'https://www.siliconera.com/feed/'
  
  # before_save :time_convert
  
  # protected
  # def time_convert
  #   puts 'DEBUG CONVERT'
  #   puts self.publish_at
  #   self.publish_at.to_time.to_i
  # end
  
  
  
  #TODO Add uniqueness constraint
  def fetchAPIData(id)
    OpenStruct.new(gameArticleRequest(id))
  end
  
  def timeCoversion(time)
    DateTime.strptime(time, '%A-%d-%b-%Y')
  end
  
  def saveAPIData(api_article)
    game_article = GameArticle.new
    if api_article.nil?
      nil
    else
      game_article.external_id = api_article.id
      game_article.author = api_article.author
      game_article.summary = api_article.summary
      game_article.title = api_article.title
      game_article.img = api_article.img
      game_article.url = api_article.url
      game_article.publish_at = api_article.published_at
      game_article.news_source = api_article.news_source
      game_article.save
      puts '---DEBUG- ARTICLE SAVE ERRORS'
      puts game_article.errors.messages
      game_article
    end
  end      
  
  #TODO Currently filter out article with no img url. Need to have something to work with the nil ones.
  #TODO This is smell! It call request 2 times!
  def fetchLatestNews(time)
    latest_newsfeed = GameArticle.where("publish_at > ? AND img IS NOT NULL",time)
    if latest_newsfeed.empty?
      latest_newsfeed = gameLatestNewsRequest(time)
      #Save to DB
      latest_newsfeed.each do |api_article|
      saveAPIData(api_article)
      end
    end
    latest_newsfeed
  end
  
    #Get News Articles from RSS Feeds of other website
    #Input is the source name
    
    
  #Gamespot feed title,link,pubDate,description
  #IGN Feed
    
  def rssFeed(source)
    rss = nil
    case source
      when 'gamespot'
        rss = RSS::Parser.parse(open(GAMESPOT_NEWS_RSS_FEED).read, false).items
      when 'ign'
        rss = RSS::Parser.parse(open(IGN_NEWS_RSS).read, false).items
      when 'gematsu'
        rss = RSS::Parser.parse(open(GEMATSU_RSS).read, false).items
    end
       #arc = GameArticle.new
        #arc.rssFeed('gamespot')
    puts 'NEWS RSS FEED RESULT'
    puts rss.count
    puts rss.first
    rss.each do |result|
    # result = { title: result.title, date: result.pubDate, link: result.link, description: result.description }
    # rss_results.push(result)
    end
    rss
  end
  
end
