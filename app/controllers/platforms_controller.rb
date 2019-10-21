# frozen_string_literal: true

class PlatformsController < ApplicationController
  def show
    game = Game.new
    @platform = Platform.friendly.find(params[:id])
    @platform_games = game.fetchPopularGamebyPlatform(@platform.name)


    render 'platforms/platform_detail'
  end
end
