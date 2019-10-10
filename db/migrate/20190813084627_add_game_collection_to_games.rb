# frozen_string_literal: true

class AddGameCollectionToGames < ActiveRecord::Migration[5.2]
  def change
    add_reference :games, :game_collection, foreign_key: true
  end
end
