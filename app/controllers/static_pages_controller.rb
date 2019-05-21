require 'uri'
require 'net/http'
class StaticPagesController < ApplicationController
  include GamesApiModule
  def home
    @summary = gamesRequest
  end
  

  def help
  end

  def about
  end

  def contact
  end
end
