class GameCollection < ApplicationRecord
  has_many :games
  validates :name, presence: true,uniqueness: true
  
  
  def fetchAPIData(game_id)
    OpenStruct.new(gamesSeriesRequest(game_id))
  end
  
  def saveAPIData(game_id)
    api_collection = fetchAPIData(game_id)
    game_collection = GameCollection.new
    
    game_collection.name = api_collection.name
    game_collection.external_id = api_collection.id
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
    puts game_collection.errors.messages
  end
  
  
end
