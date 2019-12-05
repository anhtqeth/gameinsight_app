# frozen_string_literal: true

class CreateGameArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :game_articles do |t|
      t.integer :external_id
      t.string :author
      t.text :summary
      t.string :img
      #t.date :created_at
      t.string :title
      t.string :url
      t.string :news_source

      t.timestamps
    end
  end
end
