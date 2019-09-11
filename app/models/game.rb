class Game < ApplicationRecord
  has_and_belongs_to_many :platforms
  has_and_belongs_to_many :game_genres
  
  has_many :screenshots, dependent: :destroy
  has_many :game_videos, dependent: :destroy
  has_many :game_release_dates, dependent: :destroy
  
  belongs_to :game_collection,  optional: true
  
  has_many :game_article_collection, dependent: :destroy
  has_many :involved_companies, dependent: :destroy
  has_many :companies, :through => :involved_companies
  
  
  validates :name,:summary,:first_release_date, presence: true
  validates :external_id, uniqueness: true
  
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  #TODO - Refactor this model
  #TODO - Put all API request to private?
  def fetchAPIData(id)
     OpenStruct.new(gamesListProcess(id))
  end

  def saveAPIData(id)
     game_detail = 3(id)
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
        #TODO - Need something meaninful here
     end
     
     if game_detail.first_release_date == 'NA'
      game.first_release_date = Time.now - 15.years
     else
      game.first_release_date = DateTime.strptime(game_detail.first_release_date.to_s,'%s') 
     end
     game.popularity = game_detail.popularity
     game.save
     saveGameRelatedData(id)
     game
  end
  
  
  def fetchLatestRelease(platform)
    min_time = Date.parse((3.weeks.ago).to_s)
    max_time = Date.parse(Time.now.to_s)
    #latest_release = Game.where("first_release_date BETWEEN ? AND ? and platform like ?",min_time,max_time,"%#{platform}%") #DEV Query
    # latest_release = Game.where("first_release_date BETWEEN ? AND ?",
    # min_time,max_time).joins("INNER JOIN games_platforms p ON p.game_id = games.id")
    # .where("p.platform_id = ?",Platform.find_by(name: platform).id) 
    # if latest_release.empty?
    #   latest_release_ids = gameAltRecentRelease(platform).each.map{|x| x["id"]}.map.to_a
    #   latest_release = gamesListProcess(latest_release_ids)
    #   latest_release_ids.each do |game_id|
    #     saveAPIData(game_id)
    #   end
    # end
    # latest_release
    
    Rails.cache.fetch("#{platform}/latest_releases", expires_in: 7.days) do
      latest_release_ids = gameAltRecentRelease(platform).each.map{|x| x["id"]}.map.to_a
      latest_release_ids.each do |id|
         if Game.find_by(external_id: id).nil?
          saveAPIData(id)
         else
          #Update popularity here?
         end
      end
    end
    
    Game.where("first_release_date BETWEEN ? AND ?",min_time,max_time).joins("INNER JOIN games_platforms p ON p.game_id = games.id").where("p.platform_id = ?",Platform.find_by(name: platform).id)
  end
  
  #Fetch popular and sort by popularity desc. 
  #If result is empty, get data from API, saved to db for subsequence call.
  #Params: platform - name of the platform
  def fetchPopularGamebyPlatform(platform)
    time = Date.parse(Time.now.to_s)
    
    Rails.cache.fetch("#{time}_#{platform}/popular_upcoming_releases", expires_in: 7.days) do
      savePopularGame(platform)
    end
    
    Game.where("first_release_date < ?",time).order(popularity: :desc).joins("INNER JOIN games_platforms p ON p.game_id = games.id").where("p.platform_id = ?",Platform.find_by(name: platform).id).limit(10)
    
  end
  
  #This is to get the correct popular game
  def savePopularGame(platform)
    popular_games_id = popularGamesByPlatform(platform).each.map{|x| x["id"]}.map.to_a
    popular_games_id.each do |id|
      if Game.find_by(external_id: id).nil?
        saveAPIData(id)
      else
        #Update popularity here?
      end
    end
  end
  
  def fetchPopularUpcomingRelease
    time = Date.parse(Time.now.to_s)
    
    Rails.cache.fetch("#{time}/popular_upcoming_releases", expires_in: 7.days) do
      saveAPIPopularGame
    end
    
    Game.order(popularity: :desc).where("first_release_date > ?",time)
  end
  
  def saveAPIPopularGame
    id_array = gamePopularUpcomingRelease
      id_array.each do |id|
        if Game.find_by(external_id: id).nil?
          saveAPIData(id)
        else
        #Update popularity here?
        end
    end
  end
  
  #Result from API data does not response to most view code
  #Need this to reformat the result one more time
  #Input: game_data(OpenStruct)
  #TODO - Make this a little generic
  #TODO - This look ugly, refactor this code
  def formatApiResult(game_data)
    #Hashes -> OpenStruct
    #Map name to Array
    game_data.platforms.nil? ?  game_data.platforms = [] : game_data.platforms = game_data.platforms.map{|x| OpenStruct.new(x)} #.map{|z| z.name}
    game_data.genres.nil? ? game_data.genres = nil  : game_data.genres = game_data.genres.map{|x| OpenStruct.new(x)} #.map{|z| z.name}
    game_data.cover.nil? ? game_data.cover = nil : game_data.cover = game_data.cover["url"].sub('t_thumb','t_cover_big')
    game_data.collection.nil? ? game_data.collection = [] : game_data.collection = game_data.collection["name"]
    game_data.first_release_date.nil? ? game_data.first_release_date = nil : game_data.first_release_date = DateTime.strptime(game_data.first_release_date.to_s,'%s')
    game_data
  end
  
  #Call to API to search for game
  #Input: game name
  #Output: list of game
  def findApiGames(name,saved_ex_ids)
    gamesSearchRequest(name,saved_ex_ids).map{|x| formatApiResult(OpenStruct.new(x))}
    #gamesSearchRequest(name).map{|x| OpenStruct.new(x)}
  end
  
  

  #TODO - Make this more flexible
  #TODO - Probably duplicate with api result
  def findGames(name) 
    rs = Game.where("name LIKE ?","%#{name}%")
    saved_ex_ids = rs.map(&:external_id)
    #Add rs external_id to an array
    #Use this array as a filter for the api call
    api_rs = findApiGames(name,saved_ex_ids)
    #rs.empty? ? findApiGames(name) : rs
    [rs,api_rs]
  end
  
  def duplicatesDestroy(title)
    dup_list = Game.where(name: title).group_by(&:name)
    dup_list.values.each do |dup|
      dup.pop #leave one
      dup.each(&:destroy) #destroy other
    end
  end
  
  private
  #After a new game is added, an update to other model is also required. 
  #As these model reference back to game. This need to be executed after a game is saved.
  #Private method
  #TODO - Can Refactor this using before_save or after_save?
  def saveGameRelatedData(id)
     #TODO - Move below to a function
     release_date = GameReleaseDate.new
     release_date.saveAPIData(id)
     screenshot = Screenshot.new
     screenshot.saveAPIData(id)
     videos = GameVideo.new
     videos.saveAPIData(id)
     company = Company.new
     company.saveAPIData(id,'Publisher')
     company.saveAPIData(id,'Developer')
  end
  
  def findGamesbyGenre(game_genre)
    
    
  end
  
 
  
  
end
