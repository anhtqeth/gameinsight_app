class FetchGamesCollectionJob < ApplicationJob
  queue_as :default
  def perform(id)
    game_collection = GameCollection.new
    game_collection.saveAPIData(id)
  end
end
