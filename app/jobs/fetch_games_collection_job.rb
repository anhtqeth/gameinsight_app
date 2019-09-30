class FetchGamesCollectionJob < ApplicationJob
  queue_as :default

  def perform(id) #perform(game)
    # if game.game_collection.nil?
      game_collection = GameCollection.new
      game_collection.saveAPIData(id)
    # else
    #   puts "Already updated collection"
    # end
  end
end
