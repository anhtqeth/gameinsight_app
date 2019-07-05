class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.integer :external_id
      t.string :name
      t.text :summary
      t.text :storyline
      t.string :cover
      t.text :platforms, array: true #, default: [].to_yaml
      t.string :genres
      t.date :first_release_date
      t.timestamps
    end
  end
end
