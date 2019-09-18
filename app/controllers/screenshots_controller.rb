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
  
  def create
    @screenshot = Screenshot.new(screenshot_params)
    if @screenshot.save
      flash.now[:success] = "Screenshot added!"
      redirect_back(fallback_location: root_path)
    else
      puts @screenshot.errors.full_messages
      redirect_back(fallback_location: root_path)
    end
  end
  
  private 
  
    def screenshot_params
      params.require(:screenshot).permit(:url,:width,:height,:game_id)
    end
  
  
end
