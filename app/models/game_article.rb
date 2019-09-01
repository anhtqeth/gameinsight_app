class GameArticle < ApplicationRecord
  validates :url,:title,:news_source,:publish_at,  presence: true
  belongs_to :game_article_collection,  optional: true
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
  
end
