class FetchGamesCollectionJob < ApplicationJob
  queue_as :default

  def perform(game)
    if game.game_collection.nil?
      game_collection = GameCollection.new
      game_collection.saveAPIData(game.external_id)
    else
      puts "Already updated collection"
    end
  end
end
