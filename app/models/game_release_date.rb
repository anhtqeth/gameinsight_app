class GameReleaseDate < ApplicationRecord
  belongs_to :game
  belongs_to :platform
  
  enum region: [ :REGION_LANGUAGE_NULL, :EUROPE, :NORTH_AMERICA, :AUSTRALIA, 
  :NEW_ZEALAND, :JAPAN, :CHINA, :ASIA, :WORLDWIDE, :HONG_KONG, :SOUTH_KOREA]
  enum date_format_category: [:YYYYMMMMDD, :YYYYMMMM, 
  :YYYY, :YYYYQ1, :YYYYQ2, :YYYYQ3, :YYYYQ4, :TBD]
  
  
  def fetchAPIData(id)
    result = gameReleaseDateRequest(id)
    result.map{|release_data| release_data = OpenStruct.new(release_data)}
  end
  
  #Get release data from API request
  #Check if game & platform exist before save
  #Save to db with data from API
  def saveAPIData(id)
    release_data = fetchAPIData(id)
    release_data.each do |release_date|
      
      puts 'DEBUG --- Release data here'
      puts release_date
      puts 'release category...'
      puts release_date.category
      puts release_date.created_at
      
      game_release_dates = GameReleaseDate.new
      game_release_dates.date_format_category = release_date.category
      game_release_dates.date =  DateTime.strptime(release_date.date.to_s,'%s') 
      game_release_dates.region = release_date.region
      
      if Game.find_by_external_id(release_date.game).nil?
        game = Game.new
        game_release_dates.game = game.saveAPIData(release_date.game)
      else
        game_release_dates.game = Game.find_by_external_id(release_date.game)
      end
      
      if Platform.find_by_external_id(release_date.platform).nil?
        platform = Platform.new
        game_release_dates.game = platform.saveAPIData(release_date.platform)
      else
        game_release_dates.platform = Platform.find_by_external_id(release_date.platform) 
      end
      
      game_release_dates.month = release_date.m
      game_release_dates.year = release_date.y
      
      game_release_dates.save
      game_release_dates
    end
  
  end
  
  def getReleaseDatebyRegion
  
  end
  
end
