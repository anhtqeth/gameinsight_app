class AddSlugToGameGenres < ActiveRecord::Migration[5.2]
  def change
    add_column :game_genres, :slug, :string
    add_index :game_genres, :slug, unique: true
  end
end
