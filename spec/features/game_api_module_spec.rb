require 'spec_helper'
require 'rails_helper'


RSpec.feature "Get Video Games Details", :type => :feature  do
  include GamesApiModule
  scenario "User click game details" do
    detail = gamesRequest(2062)
    expect(detail).not_to be_nil
  end
  
  scenario "Showing NewsFeed" do
    detail = gameNewsFeedRequest(2271)
    expect(detail).not_to be_nil
  end
  
  scenario "Showing game Cover" do
    game_cover = gameCoverRequest(2062)
    expect(game_cover).not_to be_nil
  end
  
  scenario "Showing game Screenshot" do
    game_screenshots = gameScreenshotRequest(2062)
    expect(game_screenshots).not_to be_nil
  end
  
  scenario "Showing Games Series of a game" do
    result = gamesSeriesRequest(777777)
    expect(result).not_to be_nil
    
  end
  
  scenario "Process Game Card List base on game Array" do
    ids_array = gamesSeriesRequest(777777)
    result = gamesListProcess(ids_array)
    
    expect(result).not_to be_nil
  end
  
  scenario "Showing the most recent release game" do 
    time_now = Time.current.to_time.to_i
    result = gameRecentRelease
    expect(result).not_to be_nil
    result.each do |rs|
      expect(rs["date"]).to be > time_now
    end
  end
  
  scenario "Showing upcoming game with platform based on popularity" do
    #Cyberpunk 2077 id 1877
    time_now = Time.current.to_time.to_i
    pop = 180
    result = gamePopularUpcomingRelease
    expect(result).not_to be_nil
    result.each do |rs|
      expect(rs["first_release_date"]).to be > time_now
      expect(rs["popularity"]).to be > pop
    end
  end
  
  scenario "Showing list of game cards of current popular game" do
    ids_array = gamePopularUpcomingRelease
    expect(ids_array.first).to be_a(Integer)
    expect(ids_array).not_to be_empty
    result = gamesListProcess(ids_array)
    expect(result).not_to be_nil
    result.each do |rs|
      expect(rs).to have_key(:name)
      expect(rs).to have_key(:summary)
      expect(rs).to have_key(:platform)
      expect(rs).to have_key(:first_release_date)
    end
  end
  
end