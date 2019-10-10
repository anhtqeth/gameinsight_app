# frozen_string_literal: true

class CreteGameGenresGamesJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_join_table :games, :game_genres do |t|
      t.index :game_id
      t.index :game_genre_id
    end
  end
end
