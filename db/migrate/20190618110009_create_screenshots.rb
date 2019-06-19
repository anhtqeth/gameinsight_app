class CreateScreenshots < ActiveRecord::Migration[5.2]
  def change
    create_table :screenshots do |t|
      t.integer :external_id
      t.string :url
      t.integer :width
      t.integer :height
      t.references :game, foreign_key: true
      t.timestamps
    end
  end
end
