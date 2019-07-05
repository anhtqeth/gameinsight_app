class GameArticle < ApplicationRecord
  validates :author,:url,:title,:news_source,  presence: true
  
  def fetchAPILatestNews(date)
     gameLatestNewsRequest(date)
  end
  
  def fetchAPIData(id)
    OpenStruct.new(gameArticleRequest(id))
  end
  
  def timeCoversion(time)
    #DateTime.strptime(time.to_s,'%s') 
    DateTime.strptime(time, '%A-%d-%b-%Y')
  end
  
  def saveAPIData(id)
      game_article = GameArticle.new
      api_article = fetchAPIData(id)
      game_article.external_id = api_article[:id]
      game_article.author = api_article[:author]
      game_article.summary = api_article[:summary]
      game_article.title = api_article[:title]
      game_article.img = api_article[:img]
      game_article.url = api_article[:url]
      game_article.news_source = api_article[:news_source]
      game_article.save
  end      
  
  
  
end