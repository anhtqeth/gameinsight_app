require 'uri'
require 'net/http'
class StaticPagesController < ApplicationController
  include GamesApiModule
  def home
    @summary = gamesRequest.first['summary']
    @gameName = gamesRequest.first['name']
    @cover = gameCoverRequest
    @releaseDate = releaseDateRequest
    puts "This is the url #{@cover}"
  end
  

  def help
  end

  def about
  end

  def contact
  
  end

end
