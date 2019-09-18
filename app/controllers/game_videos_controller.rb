class GameVideosController < ApplicationController
 
  def destroy
    GameVideo.find(params[:id]).destroy
    flash.now[:success] = "Game Video Deleted!"
    redirect_back(fallback_location: root_path)
  end
  
  def edit
    @screenshots = GameVideo.find(params[:id])
    
  end

  def update
    @screenshot = GameVideo.find(params[:id])
    if @screenshot.update_attributes(game_params)
      flash.now[:success] = "Game Video Updated"
      redirect_back(fallback_location: root_path)
    else
      render 'edit'
    end
    
  end
  
  def create
    @video = GameVideo.new(video_params)
    if @video.save
      flash.now[:success] = "Video added!"
      redirect_back(fallback_location: root_path)
    else
      puts @video.errors.full_messages
      redirect_back(fallback_location: root_path)
    end
  end
  
  private 
  
    def video_params
      params.require(:game_video).permit(:url,:name,:description,:game_id)
    end
  


end
