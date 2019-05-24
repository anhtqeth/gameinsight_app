require 'uri'
require 'net/http'
class StaticPagesController < ApplicationController
  include GamesApiModule
  def home
    # @summary = gamesRequest.first['summary']
    # @gameName = gamesRequest.first['name']
    # @cover = gameCoverRequest
    # @releaseDate = releaseDateRequest
    #   puts "This is the url #{@cover}"
    @game_names = gamesListProcess[0]
    
    @game_summaries = gamesListProcess[1]
    
    @game_covers = gamesListProcess[2]
    
    
  end
  

  def help
  end

  def about
  end

  def contact
  
  end

end
