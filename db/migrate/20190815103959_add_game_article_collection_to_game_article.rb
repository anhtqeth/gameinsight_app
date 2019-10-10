# frozen_string_literal: true

class AddGameArticleCollectionToGameArticle < ActiveRecord::Migration[5.2]
  def change
    add_reference :game_articles, :game_article_collection, foreign_key: true
  end
end
