class GameCollection < ApplicationRecord
  has_many :games
  
  validates :name, presence: true,uniqueness: true
  
  
  def fetchAPIData(collection_id)
    OpenStruct.new(gamesSeriesRequest(collection_id))
  end
  
  def saveAPIData(collection_id)
    api_collection = fetchAPIData(collection_id)
    game_collection = GameCollection.new
    game_collection.name = api_collection.name
    api_collection.games.each do |id|
      
      game = Game.find_by_external_id(id)
      if game.nil?
        game = Game.new
        game_collection.games << game.saveAPIData(id)
      else
        game_collection.games << game
      end
    end
    game_collection.save
  end
  
end
