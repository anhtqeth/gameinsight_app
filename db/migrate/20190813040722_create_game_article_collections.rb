class CreateGameArticleCollections < ActiveRecord::Migration[5.2]
  def change
    create_table :game_article_collections do |t|
      t.integer :external_id
      t.string :name
      t.references :game, foreign_key: true
      t.references :game_article, foreign_key: true

      t.timestamps
    end
  end
end
