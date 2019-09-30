class FetchGamesCollectionJob < ApplicationJob
  queue_as :default

  def perform(*args)
    game_collection = GameCollection.new
      
    if game_collection.saveAPIData(game.external_id).nil?
      @game_card_carousel_list = nil
    else
      @game_card_carousel_list = game.game_collection.games
      @size = @game_card_carousel_list.size/2 #TODO - Move this to helper
    end
  end
end
