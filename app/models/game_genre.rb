# frozen_string_literal: true

# == Schema Information
#
# Table name: game_genres
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  slug        :string
#  external_id :integer
#

class GameGenre < ApplicationRecord
  has_and_belongs_to_many :games
  validates :name, :description, :external_id, presence: true
  validates :name, uniqueness: true
  validates :external_id, uniqueness: true
  
  scope :popular_games,  -> (genre_name){GameGenre.find_by_name(genre_name).games.order(popularity: :desc)}

  extend FriendlyId
  friendly_id :name, use: :slugged

  def fetchAPIData(id)
    gameGenreRequest(id)
  end

  def saveAPIData(id)
    
    genre_detail      = fetchAPIData(id)
    genre             = GameGenre.new
    genre.external_id = genre_detail['id']
    genre.name        = genre_detail['name']
    genre.description = 'Define by another CMS'
    genre.save

    genre
  end

  def getAllApiData
    genre_ids = fetchAPIData(nil)
    genre_ids = genre_ids.map { |x| x['id'] }
    genre_ids.each do |x|
      saveAPIData(x)
    end
  end
end

# Fighting
# Role-playing (RPG)
# Simulator
# Sport
# Hack and slash/Beat 'em up
# Adventure
