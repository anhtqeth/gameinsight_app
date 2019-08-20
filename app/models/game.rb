class Game < ApplicationRecord
  has_and_belongs_to_many :platforms
  has_and_belongs_to_many :game_genres
  
  has_many :screenshots, dependent: :destroy
  has_many :game_videos, dependent: :destroy
  has_many :game_release_dates, dependent: :destroy
  
  belongs_to :game_collection,  optional: true
  
  has_many :game_article_collection, dependent: :destroy
  has_many :involved_companies
  has_many :companies, :through => :involved_companies
  
  
  validates :name,:summary,:cover,:first_release_date, presence: true
  
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  def fetchAPIData(id)
     OpenStruct.new(gamesListProcess(id))
  end
  
  #rails g migration AddGameCollectionToGames game_collection:references
  
  def saveAPIData(id)
     game_detail = fetchAPIData(id)
     game=Game.new
     
     game.external_id = game_detail.id
     game.name = game_detail.name
     game.summary = game_detail.summary
     game.cover = game_detail.cover
     game.storyline = game_detail.storyline
     
     puts game_detail.platform
     
     unless game_detail.platform == 'NA'
        game_detail.platform.each do |x|
          if Platform.find_by(external_id: x).nil?
            platform = Platform.new
            game.platforms << platform.saveAPIData(x)
          else
            platform = Platform.find_by(external_id: x)
            game.platforms << platform
          end
        end
     else
        
     end
    
     puts 'GENRES'
     puts game_detail.genres
     unless game_detail.genres == 'NA'
        game_detail.genres.each do |x|
          if GameGenre.find_by(external_id: x).nil?
            genres = GameGenre.new
            game.game_genres << genres.saveAPIData(x)
          else
            genres = GameGenre.find_by(external_id: x)
            game.game_genres << genres
          end
        end
     else
        #Need something meaninful here
     end
     
     if game_detail.first_release_date == 'NA'
      game.first_release_date = Time.now - 15.years
     else
      game.first_release_date = DateTime.strptime(game_detail.first_release_date.to_s,'%s') 
     end
     game.popularity = game_detail.popularity
     game.save
     #TODO - Move below to a function
     release_date = GameReleaseDate.new
     release_date.saveAPIData(id)
     screenshot = Screenshot.new
     screenshot.saveAPIData(id)
     videos = GameVideo.new
     videos.saveAPIData(id)
     
     game
  end

  def fetchLatestRelease(platform)
    min_time = Date.parse((1.month.ago).to_s)
    max_time = Date.parse(Time.now.to_s)
    #latest_release = Game.where("first_release_date BETWEEN ? AND ? and platform like ?",min_time,max_time,"%#{platform}%") #DEV Query
    latest_release = Game.where("first_release_date BETWEEN ? AND ?",min_time,max_time).joins("INNER JOIN games_platforms p ON p.game_id = games.id").where("p.platform_id = ?",Platform.find_by(name: platform).id) 
    if latest_release.empty?
      latest_release_ids = gameAltRecentRelease(platform).each.map{|x| x["id"]}.map.to_a
      latest_release = gamesListProcess(latest_release_ids)
      latest_release_ids.each do |game_id|
        saveAPIData(game_id)
      end
    end
    latest_release
  end
  
  #Fetch popular and sort by popularity desc. 
  #If result is empty, get data from API, saved to db for subsequence call.
  #Params: platform - name of the platform
  def fetchPopularGamebyPlatform(platform)
    time = Date.parse(Time.now.to_s)
    popular_games = Game.where("first_release_date < ?",time).order(popularity: :desc).joins("INNER JOIN games_platforms p ON p.game_id = games.id").where("p.platform_id = ?",Platform.find_by(name: platform).id).limit(10)
    if popular_games.empty?
      popular_games_id = popularGamesByPlatform(platform).each.map{|x| x["id"]}.map.to_a
      popular_games_id.each do |id|
        saveAPIData(id)
      end
      popular_games = gamesListProcess(popular_games_id)
    end
    popular_games
  end
  
  #This is to get the correct popular game
  def savePopularGame(platform)
    popular_games_id = popularGamesByPlatform(platform).each.map{|x| x["id"]}.map.to_a
    popular_games_id.each do |id|
        saveAPIData(id)
    end
  end
  
  def fetchPopularUpcomingRelease
    time = Date.parse(Time.now.to_s)
    popular_upcoming_games = Game.order(popularity: :desc).where("first_release_date > ?",time)
    
    if popular_upcoming_games.empty? or popular_upcoming_games.size < 4
      id_array = gamePopularUpcomingRelease
      id_array.each do |id|
        saveAPIData(id)
      end
      popular_upcoming_games = gamesListProcess(gamePopularUpcomingRelease)
    end
    popular_upcoming_games
  end
  
end
