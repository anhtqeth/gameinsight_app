class PlatformsController < ApplicationController
  
  def show
    @platform = Platform.friendly.find(params[:id])
    
    render 'platforms/platform_detail'
  end
  
end
