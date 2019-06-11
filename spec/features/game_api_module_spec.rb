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
end