# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'

describe 'static_pages/home.html.erb' do
  it 'display upcoming popular game' do
    # dummy_game_card_list = [{:id=>2059, :name=>"Yakuza", :summary=>"Just as Kazuma, a former rising star in the Yakuza, emerges from prison after a murder cover-up, 10 billion yen vanishes from the Yakuza vault, forcing him once again into their brutal, lawless world. A mysterious young girl will lead Kazuma to the answers if he can keep her alive.", :cover=>"//images.igdb.com/igdb/image/upload/t_cover_big/e3cdy0d77eduopr5en37.jpg"}, {:id=>2060, :name=>"Yakuza 2", :summary=>"Yakuza 2 plunges you once more into the violent Japanese underworld. In intense brutal clashes with rival gangs, the police, and the Korean mafia, you will have opportunities to dole out more brutal punishment. As the heroic Kazuma Kiryu from the original Yakuza, explore Tokyo and now Osaka. Wander through the back alleys of Japan's underworld while trying to prevent an all-out gang war in over 16 complex, cinematic chapters written by Hase Seishu, the famous Japanese author who also wrote the first Yakuza. Endless conflicts and surprise plot twists will immerse you in a dark shadowy world where only the strongest will survive.", :cover=>"//images.igdb.com/igdb/image/upload/t_cover_big/ozhhq6bsu5elgkhbraoe.jpg"}, {:id=>2061, :name=>"Yakuza 3", :summary=>"Introducing the next cinematic chapter in the prestigious Yakuza series renowned for it's authentic, gritty and often violent look at modern Japan. Making its first appearance exclusively on the PlayStation 3 computer entertainment system, the rich story and vibrant world of Yakuza 3 lets players engage in intense brutal clashes within the streets of Okinawa, and the vibrant and often dangerous city of Tokyo where only the strongest will survive.", :cover=>"//images.igdb.com/igdb/image/upload/t_cover_big/amhmvuaybvl0epgcpfys.jpg"}, {:id=>2062, :name=>"Yakuza 4", :summary=>"Yakuza 4 is the fourth game in Sega's crime drama series, known as 'Ryu ga Gotoku' in Japan. As a first for the series, the story is split between the viewpoints of four different protagonists.", :cover=>"//images.igdb.com/igdb/image/upload/t_cover_big/udb2eilafrf5yujesuq8.jpg"}]
    # dummy_feature_list = [{"id"=>305890, "alpha_channel"=>false, "animated"=>false, "game"=>113344, "height"=>2160, "image_id"=>"sc6k0y", "url"=>"//images.igdb.com/igdb/image/upload/t_1080p/sc6k0y.jpg", "width"=>3840}, {"id"=>305892, "alpha_channel"=>false, "animated"=>false, "game"=>113344, "height"=>2160, "image_id"=>"sc6k10", "url"=>"//images.igdb.com/igdb/image/upload/t_1080p/sc6k10.jpg", "width"=>3840}, {"id"=>305893, "alpha_channel"=>false, "animated"=>false, "game"=>113344, "height"=>2160, "image_id"=>"sc6k11", "url"=>"//images.igdb.com/igdb/image/upload/t_1080p/sc6k11.jpg", "width"=>3840}, {"id"=>305895, "alpha_channel"=>false, "animated"=>false, "game"=>113344, "height"=>1080, "image_id"=>"sc6k13", "url"=>"//images.igdb.com/igdb/image/upload/t_1080p/sc6k13.jpg", "width"=>1920}, {"id"=>305894, "alpha_channel"=>false, "animated"=>false, "game"=>113344, "height"=>1080, "image_id"=>"sc6k12", "url"=>"//images.igdb.com/igdb/image/upload/t_1080p/sc6k12.jpg", "width"=>1920}, {"id"=>305898, "alpha_channel"=>false, "animated"=>false, "game"=>113344, "height"=>2160, "image_id"=>"sc6k16", "url"=>"//images.igdb.com/igdb/image/upload/t_1080p/sc6k16.jpg", "width"=>3840}, {"id"=>305899, "alpha_channel"=>false, "animated"=>false, "game"=>113344, "height"=>2160, "image_id"=>"sc6k17", "url"=>"//images.igdb.com/igdb/image/upload/t_1080p/sc6k17.jpg", "width"=>3840}, {"id"=>305900, "alpha_channel"=>false, "animated"=>false, "game"=>113344, "height"=>2160, "image_id"=>"sc6k18", "url"=>"//images.igdb.com/igdb/image/upload/t_1080p/sc6k18.jpg", "width"=>3840}, {"id"=>305889, "alpha_channel"=>false, "animated"=>false, "game"=>113344, "height"=>1080, "image_id"=>"sc6k0x", "url"=>"//images.igdb.com/igdb/image/upload/t_1080p/sc6k0x.jpg", "width"=>1920}, {"id"=>305891, "alpha_channel"=>false, "animated"=>false, "game"=>113344, "height"=>2160, "image_id"=>"sc6k0z", "url"=>"//images.igdb.com/igdb/image/upload/t_1080p/sc6k0z.jpg", "width"=>3840}]
    assign(:game_card_list, dummy_game_card_list)
    assign(:dummy_feature_list, dummy_feature_list)
    render
  end
end
