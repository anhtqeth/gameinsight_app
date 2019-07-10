class Game < ApplicationRecord
  validates :name,:summary,:cover,:genres,:first_release_date, presence: true
  
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
     game.platform = game_detail.platform
     game.genres = game_detail.genres
     puts game_detail.first_release_date
     if game_detail.first_release_date = 'NA'
      game.first_release_date = Time.now - 15.years
     else
      game.first_release_date = DateTime.strptime(game_detail.first_release_date.to_s,'%s') 
     end
        
     game.save
     game
  end
  
  def fetchLatestRelease(platform)
    case platform 
      when 'PlayStation'
        puts 'List of latest PS Game'
        platform_id = 48
      when 'Microsoft Xbox'
        puts 'List of latest Xbox Game'
        platform_id = 9
      when 'PC'
        puts 'List of latest PC Game'
        platform_id = 46
      when 'Nintendo Switch'
        puts 'List of latest Switch Game'
        platform_id = 130
      when 'iOS'
        platform_id = 39
      #TODO Add more platforms  
      else
        puts "(#{platform}) is not a valid platform"
    end
    time = Time.now - 1.month.ago
    Game.where("first_release_date > ?",time)
    
  end
  
  
end
