class GameArticleCollection < ApplicationRecord
  belongs_to :game
  belongs_to :game_article
end
