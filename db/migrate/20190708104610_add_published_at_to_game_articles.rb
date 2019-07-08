class AddPublishedAtToGameArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :game_articles, :publish_at, :integer
  end
end
