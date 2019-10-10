# frozen_string_literal: true

class CreateGameVideos < ActiveRecord::Migration[5.2]
  def change
    create_table :game_videos do |t|
      t.integer :external_id
      t.string :url
      t.string :name
      t.text :description
      t.references :game, foreign_key: true

      t.timestamps
    end
  end
end
