class GameGenreController < ApplicationController
  include ContentModule
  
  def show
    @genre_detail = renderRichText
    render 'game_genre/game_genre_detail'
  end
  
  
  
end
