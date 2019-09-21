class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :name
      t.string :feature_img
      t.integer :status
      t.references :user, foreign_key: true
      t.references :game, foreign_key: true
      t.references :company, foreign_key: true
      t.references :platform, foreign_key: true

      t.timestamps
    end
  end
end
