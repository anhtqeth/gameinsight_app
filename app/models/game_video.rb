class GameVideo < ApplicationRecord
  belongs_to :game,:dependent => :destroy
  validates :name,:url, presence: true
  
  def fetchAPIData(id)
    gamesVideoRequest(id)
  end
  
  def saveAPIData(id)
    api_game_videos = fetchAPIData(id)
    
    api_game_videos.each do |api_video|
    game_videos = GameVideo.new
    game_videos.external_id = id
    game_videos.url = api_video
      if Game.find_by_external_id(id).nil?
        game = Game.new
        game = game.saveAPIData(id)
        game_videos.game = game
        game_videos.name = game.name
      else
        game = Game.find_by_external_id(id)
        game_videos.game = game
        game_videos.name = game.name
      end
      game_videos.save
    end
  end
end
