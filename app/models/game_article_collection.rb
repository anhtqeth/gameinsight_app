class GameArticleCollection < ApplicationRecord
  belongs_to :game
  has_many :game_articles,  dependent: :destroy
  
  def fetchAPIData(id)
    gameNewsFeedRequest(id)
  end
  
  def saveAPIData(id)
    arc_collection = GameArticleCollection.new
    game = Game.find_by_external_id(id)
    
    if game.nil?
      game = Game.new
      arc_collection.game = game.saveAPIData(id)
    else
      arc_collection.game = game
      arc_collection.name = game.name
    end
    
    api_newsfeed = fetchAPIData(id)
    api_newsfeed.each do |arc|
      game_arc = GameArticle.find_by_external_id(arc.id)
      if game_arc.nil?
        game_arc = GameArticle.new
        arc_collection.game_articles << game_arc.saveAPIData(arc)
      else
        arc_collection.game_articles << game_arc
      end
      
    end
    arc_collection.save
    puts arc_collection.errors.messages
  end
end
