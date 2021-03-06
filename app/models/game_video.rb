# frozen_string_literal: true

# == Schema Information
#
# Table name: game_videos
#
#  id          :bigint           not null, primary key
#  external_id :integer
#  url         :string
#  name        :string
#  description :text
#  game_id     :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class GameVideo < ApplicationRecord
  belongs_to :game
  # validates :name,:url, presence: true

  def fetchAPIData(id)
    gamesVideoRequest(id)
  end

  def saveAPIData(id)
    api_game_videos = fetchAPIData(id)

    if api_game_videos.nil?
      game = Game.find_by_external_id(id)
      game.game_videos = []
    else
      api_game_videos.each do |api_video|
        if Game.find_by_external_id(id)
          game = Game.find_by_external_id(id)
          game.game_videos.create(external_id: id, url: api_video, name: game.name)
        else
          puts 'Cannot save game videos'
        end
      end
    end
  end
end
