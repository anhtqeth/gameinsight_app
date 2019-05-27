require 'uri'
require 'net/http'
class StaticPagesController < ApplicationController
  include GamesApiModule
  def home
    
    # feature_games_id = gamesSeriesRequest.first['games']
    
    # recent_release_id = []
    # @recent_release_date = []
    # gameReleaseDateRequest.each do |game|
    #   recent_release_id << game['game']
    #   @recent_release_date << game['date']
    # end
    # puts @recent_release_id
    # puts @recent_release_date
    
    # @game_card_list = gamesListProcess(feature_games_id)
    # puts @game_card_list
    
    # @release_game_card_list = gamesListProcess(recent_release_id)
    # puts @release_game_card_list
    
    @dummy_game_card_list = [{:name=>"Yakuza", :summary=>"Just as Kazuma, a former rising star in the Yakuza, emerges from prison after a murder cover-up, 10 billion yen vanishes from the Yakuza vault, forcing him once again into their brutal, lawless world. A mysterious young girl will lead Kazuma to the answers if he can keep her alive.", :cover=>"//images.igdb.com/igdb/image/upload/t_cover_big/e3cdy0d77eduopr5en37.jpg"},{:name=>"Yakuza 2", :summary=>"Yakuza 2 plunges you once more into the violent Japanese underworld. In intense brutal clashes with rival gangs, the police, and the Korean mafia, you will have opportunities to dole out more brutal punishment. As the heroic Kazuma Kiryu from the original Yakuza, explore Tokyo and now Osaka. Wander through the back alleys of Japan's underworld while trying to prevent an all-out gang war in over 16 complex, cinematic chapters written by Hase Seishu, the famous Japanese author who also wrote the first Yakuza. Endless conflicts and surprise plot twists will immerse you in a dark shadowy world where only the strongest will survive.", :cover=>"//images.igdb.com/igdb/image/upload/t_cover_big/ozhhq6bsu5elgkhbraoe.jpg"},{:name=>"Yakuza 3", :summary=>"Introducing the next cinematic chapter in the prestigious Yakuza series renowned for it's authentic, gritty and often violent look at modern Japan. Making its first appearance exclusively on the PlayStation 3 computer entertainment system, the rich story and vibrant world of Yakuza 3 lets players engage in intense brutal clashes within the streets of Okinawa, and the vibrant and often dangerous city of Tokyo where only the strongest will survive.", :cover=>"//images.igdb.com/igdb/image/upload/t_cover_big/amhmvuaybvl0epgcpfys.jpg"},{:name=>"Yakuza 4", :summary=>"Yakuza 4 is the fourth game in Sega's crime drama series, known as 'Ryu ga Gotoku' in Japan. As a first for the series, the story is split between the viewpoints of four different protagonists.", :cover=>"//images.igdb.com/igdb/image/upload/t_cover_big/udb2eilafrf5yujesuq8.jpg"}]
    @game_card_list = @dummy_game_card_list
    
    @dummy_feature_list = [{"id"=>244572, "game"=>55090, "height"=>720, "image_id"=>"iodd6zzceqq5jkufxpcz", "url"=>"//images.igdb.com/igdb/image/upload/t_screenshot_big/iodd6zzceqq5jkufxpcz.jpg", "width"=>1280},{"id"=>208211, "game"=>55090, "height"=>1080, "image_id"=>"wdsb42ukz39ywlzvhro4", "url"=>"//images.igdb.com/igdb/image/upload/t_screenshot_big/wdsb42ukz39ywlzvhro4.jpg", "width"=>1920},{"id"=>244573, "game"=>55090, "height"=>562, "image_id"=>"af8ueznswr8xpdkw9ukf", "url"=>"//images.igdb.com/igdb/image/upload/t_screenshot_big/af8ueznswr8xpdkw9ukf.jpg", "width"=>1000},{"id"=>208214, "game"=>55090, "height"=>1080, "image_id"=>"cxwpickwszhgdxvxdzzh", "url"=>"//images.igdb.com/igdb/image/upload/t_screenshot_big/cxwpickwszhgdxvxdzzh.jpg", "width"=>1920},{"id"=>208212, "game"=>55090, "height"=>1080, "image_id"=>"enex88ekm3se7a3vpqmp", "url"=>"//images.igdb.com/igdb/image/upload/t_screenshot_big/enex88ekm3se7a3vpqmp.jpg", "width"=>1920},{"id"=>208213, "game"=>55090, "height"=>1080, "image_id"=>"ywgv0zxrsocslwbkir8b", "url"=>"//images.igdb.com/igdb/image/upload/t_screenshot_big/ywgv0zxrsocslwbkir8b.jpg", "width"=>1920}]
    @dummy_feature_list.each do |x| 
    
    end
    
    
    @release_game_card_list = []
    
    # @game_card_list = []
    # 
    
  end
  

  def help
  end

  def about
  end

  def contact
  
  end

end
