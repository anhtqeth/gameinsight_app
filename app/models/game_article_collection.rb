class GameArticleCollection < ApplicationRecord
  belongs_to :game
  belongs_to :game_article
  
  def fetchAPIData(id)
    result = gameNewsFeedRequest(id)
    result.map{|news_data| news_data = OpenStruct.new(news_data)}
  end
  
  def saveAPIData(id)
    game_news_collection = fetchAPIData(id)
    
    game_news_collection.each do |article|
      news_collection = GameArticleCollection.new
      
      news_collection.name = article.id
      news_collection.name = article.name
      
      if Game.find_by_external_id(article.game).nil?
        game = Game.new
        game.saveAPIData(article.game)
      else
        news_collection.game = Game.find_by_external_id(article.game)
      end
      arc_id = article.pulses.join 
     
      unless GameArticle.find_by_external_id(arc_id).nil? && game_article.fetchAPIData(arc_id).nil?
        game_article = GameArticle.new
        news_collection.game_article = game_article.saveAPIData(arc_id)
      else
        news_collection.game_article = GameArticle.find_by_external_id(arc_id) 
      end
      
      next if news_collection.game_article.nil?
      
      news_collection.save
      puts '---DEBUG- NEWS COLLECTION SAVE ERRORS'
      puts news_collection.errors.messages
      news_collection
    end
    
  end
  
end
