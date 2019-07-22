class Game < ApplicationRecord
  validates :summary,:cover,:genres,:first_release_date, presence: true
  validates :name,uniqueness: true
  def fetchAPIData(id)
     game_detail =  OpenStruct.new(gamesListProcess(id))
     game_detail 
  end
  
  def saveAPIData(id)
     game_detail = fetchAPIData(id)
     game=Game.new
     game.external_id = game_detail.id
     game.name = game_detail.name
     game.summary = game_detail.summary
     game.storyline = game_detail.storyline
     game.cover = game_detail.cover
     #game.platform = game_detail.platform # for Dev
     game.platform = [game_detail.platform] #for PROD Array
     game.genres = game_detail.genres
     puts game_detail.first_release_date
     if game_detail.first_release_date == 'NA'
      game.first_release_date = Time.now - 15.years
     else
      game.first_release_date = DateTime.strptime(game_detail.first_release_date.to_s,'%s') 
     end
        
     game.save
     game
  end
  
  def fetchLatestRelease(platform)
    #TODO - Implement Platform Model & Release model
    case platform 
      when 'PlayStation 4'
        puts 'Most Popular PS4 Game'
        platform_id = 48
      when 'Microsoft Xbox'
        puts 'Most Popular Xbox Game'
        platform_id = 49
        
      when 'PC'
        puts 'Most Popular PC Game'
        platform_id = 6
      when 'Nintendo Switch'
        puts 'Most Popular Switch Game'
        platform_id = 130
      when 'iOS'
        platform_id = 39
      #TODO Add more platforms  
      else
        puts "(#{platform}) is not a valid platform" #  & m =#{month} & y=#{year} 
    end
    
    min_time = Date.parse((1.month.ago).to_s)
    max_time = Date.parse(Time.now.to_s)
    platform = 'PlayStation 4'
    #latest_release = Game.where("first_release_date BETWEEN ? AND ? and platform like ?",min_time,max_time,"%#{platform}%") #DEV Query
    latest_release = Game.where('first_release_date BETWEEN ? AND ? and ? = ANY (platform)',min_time,max_time,platform)  #PROD Query
    if latest_release.empty?
      latest_release_ids = gameAltRecentRelease(platform).each.map{|x| x["id"]}.map.to_a
      latest_release = gamesListProcess(latest_release_ids)
      latest_release_ids.each do |game_id|
        saveAPIData(game_id)
      end
    end
    latest_release
  end
  
  def fetchPopularGamebyPlatform(platform)
    case platform 
      when 'PlayStation 4'
        puts 'Most Popular PS4 Game'
        platform_id = 48
      when 'Microsoft Xbox'
        puts 'Most Popular Xbox Game'
        platform_id = 49
        
      when 'PC'
        puts 'Most Popular PC Game'
        platform_id = 6
      when 'Nintendo Switch'
        puts 'Most Popular Switch Game'
        platform_id = 130
      when 'iOS'
        platform_id = 39
      #TODO Add more platforms  
      else
        puts "(#{platform}) is not a valid platform" #  & m =#{month} & y=#{year} 
    end
    
    popular_games_id = popularGamesByPlatform(platform).each.map{|x| x["id"]}.map.to_a
    popular_release = gamesListProcess(popular_games_id)
    
  end
  
  
end
