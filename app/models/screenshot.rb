class Screenshot < ApplicationRecord
  belongs_to :game, :dependent => :destroy
  validates :url,:width,:height, presence: true
  def fetchAPIData(id)
    screenshots = gameScreenshotRequest(id)
    screenshots
  end
  
  def saveAPIData(id)
    api_game_screenshots = fetchAPIData(id)
    api_game_screenshots.each do |game_screenshot|
      screenshot = Screenshot.new
      screenshot.external_id = id
      screenshot.url = game_screenshot["url"]
      screenshot.width = 1920
      screenshot.height = 1080
      if Game.find_by_external_id(id).nil?
        game = Game.new
        game = game.saveAPIData(id)
        screenshot.game = game
      else
        game = Game.find_by_external_id(id)
        screenshot.game = game
      end
      screenshot.save
    end
  end
  
end
