# frozen_string_literal: true

class AddExidToGameGenres < ActiveRecord::Migration[5.2]
  def change
    add_column :game_genres, :external_id, :integer
  end
end
