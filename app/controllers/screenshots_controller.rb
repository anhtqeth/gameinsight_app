class ScreenshotsController < ApplicationController
  
  def destroy
    Screenshot.find(params[:id]).destroy
    flash.now[:success] = "Screenshot Deleted!"
    redirect_back(fallback_location: root_path)
  end
  
  def edit
    @screenshots = Screenshot.find(params[:id])
    
  end

  def update
    @screenshot = Screenshot.find(params[:id])
    if @screenshot.update_attributes(game_params)
      flash.now[:success] = "Screenshot Updated"
      redirect_back(fallback_location: root_path)
    else
      render 'edit'
    end
    
  end
  
  def new
    @screenshot = Screenshot.new
  end
  
end
