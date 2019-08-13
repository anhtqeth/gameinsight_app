class CreateGameCollections < ActiveRecord::Migration[5.2]
  def change
    create_table :game_collections do |t|
      t.integer :external_id
      t.string :name
      t.string :url
      t.text :description
      t.references :game, foreign_key: true

      t.timestamps
    end
  end
end
