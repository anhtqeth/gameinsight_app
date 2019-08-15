class CreateGameReleaseDates < ActiveRecord::Migration[5.2]
  def change
    create_table :game_release_dates do |t|
      t.date :date
      t.references :game, foreign_key: true
      t.references :platform, foreign_key: true
      t.integer :region
      t.integer :month
      t.integer :year
      t.integer :date_format_category

      t.timestamps
    end
  end
  
  
end
