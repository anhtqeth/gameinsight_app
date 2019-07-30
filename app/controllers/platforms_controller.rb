class PlatformsController < ApplicationController
  
  def show
    @platform = Platform.friendly.find(params[:id])
  end
  
end
