class CreatePlatforms < ActiveRecord::Migration[5.2]
  def change
    create_table :platforms do |t|
      t.integer :external_id
      t.string :abbreviation
      t.string :alt_name
      t.integer :generation
      t.string :name
      t.string :platform_logo
      t.text :summary
      t.text :details
      t.string :url
      t.timestamps
    end
  end
end