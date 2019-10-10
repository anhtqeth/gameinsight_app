# frozen_string_literal: true

class CreateGameGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :game_genres do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
