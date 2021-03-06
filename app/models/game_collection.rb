# frozen_string_literal: true

# == Schema Information
#
# Table name: game_collections
#
#  id          :bigint           not null, primary key
#  external_id :integer
#  name        :string
#  url         :string
#  description :text
#  game_id     :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class GameCollection < ApplicationRecord
  has_many :games, dependent: :destroy
  validates :name, presence: true, uniqueness: true

  def fetchAPIData(game_id)
    gamesSeriesRequest(game_id).nil? ? nil : OpenStruct.new(gamesSeriesRequest(game_id))
  end

  def saveAPIData(game_id)
    api_collection = fetchAPIData(game_id)
    if api_collection.nil?
      nil
    else
      game_collection = GameCollection.new
      game_collection.name = api_collection.name
      game_collection.external_id = api_collection.id
      puts 'DEBUG --  LIST OF GAME IDS'
      puts api_collection.games
      api_collection.games.each do |id|
        game = Game.find_by_external_id(id)
        if game.nil?
          game = Game.new
          if game.saveAPIData(id).present?
            game_collection.games << game.saveAPIData(id)
          end
        else
          game = Game.find_by_external_id(id)
          game_collection.games << game
        end
      end
      game_collection.save
      puts game_collection.errors.messages
    end
  end
end
