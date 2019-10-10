# frozen_string_literal: true

# == Schema Information
#
# Table name: screenshots
#
#  id          :bigint           not null, primary key
#  external_id :integer
#  url         :string
#  width       :integer
#  height      :integer
#  game_id     :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Screenshot < ApplicationRecord
  belongs_to :game
  validates :url, :width, :height, presence: true
  def fetchAPIData(id)
    screenshots = gameScreenshotRequest(id)
    screenshots
  end

  def saveAPIData(id)
    puts 'Called to Screenshot saveAPIData'
    api_game_screenshots = fetchAPIData(id)
    if api_game_screenshots.nil?
      game = Game.find_by_external_id(id)
      game.screenshots = []
    else
      api_game_screenshots.each do |game_screenshot|
        if Game.find_by_external_id(id)
          game = Game.find_by_external_id(id)
          game.screenshots.create(external_id: id, url: game_screenshot['url'], width: 1920, height: 1080)
        else
          puts 'Cannot save screenshot data!'
        end
      end
    end
  end
end
