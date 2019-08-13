class GameGenre < ApplicationRecord
  has_and_belongs_to_many :games
  validates :name,:description, presence: true
  validates :name,uniqueness: true
  
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  def fetchAPIData
   gameGenreRequest
  end
  
  def saveAPIData
   genre_list = fetchAPIData
   genre_list.each do |api_detail|
    genre = GameGenre.new
    genre.name = api_detail["name"]
    genre.description = 'Define by another CMS'
    genre.save
   end
  end
  
end

# Fighting
 # Role-playing (RPG)
 # Simulator
 # Sport
 # Hack and slash/Beat 'em up
 # Adventure