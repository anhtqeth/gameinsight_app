require 'spec_helper'
require 'rails_helper'

RSpec.feature "Video Games Details", :type => :feature  do
  include GamesApiModule
  # scenario "Postman Test" do
  #   detail = postmanReq
  #   expect(detail).not_to be_nil
  # end
  
  # scenario "Showing game details" do
  #   detail = gamesRequest(55090)
  #   expect(detail).not_to be_nil
  # end
  
  # scenario "Showing NewsFeed" do
  #   detail = gameNewsFeedRequest(7442)
  #   expect(detail).not_to be_nil
  # end
  
  # scenario "Showing details of an Article" do
  #   game_article = gameArticleRequest(699963)
  #   expect(game_article).not_to be_nil
  # end
  # scenario "Showing game Cover" do
  #   game_cover = gameCoverRequest(2062)
  #   expect(game_cover).not_to be_nil
  # end
  
  # scenario "Showing game Screenshot" do
  #   game_screenshots = gameScreenshotRequest(2062)
  #   expect(game_screenshots).not_to be_nil
  # end
  
  # scenario "Showing Games Series of a game" do
  #   result = gamesSeriesRequest(777777)
  #   expect(result).not_to be_nil
    
  # end
  
  # scenario "Process Game Card List base on game Array" do
  #   ids_array = gamesSeriesRequest(777777)
  #   result = gamesListProcess(ids_array)
    
  #   expect(result).not_to be_nil
  # end
  
  # scenario "Showing the most recent release game" do 
  #   time_now = Time.current.to_time.to_i
  #   result = gameRecentRelease
  #   expect(result).not_to be_nil
  #   result.each do |rs|
  #     expect(rs["date"]).to be > time_now
  #   end
  # end
  
  # scenario "Showing upcoming game based on popularity" do
  #   #Cyberpunk 2077 id 1877
  #   time_now = Time.current.to_time.to_i
  #   pop = 200.0
  #   result = gamePopularUpcomingRelease
  #   expect(result).not_to be_nil
  #   result.each do |rs|
  #     expect(rs["first_release_date"]).to be > time_now
  #     expect(rs["popularity"]).to be > pop
  #   end
  # end
  
  # scenario "Showing list of game cards of current popular game" do
  #   ids_array = gamePopularUpcomingRelease
  #   expect(ids_array.first).to be_a(Integer)
  #   expect(ids_array).not_to be_empty
  #   result = gamesListProcess(ids_array)
  #   expect(result).not_to be_nil
  #   result.each do |rs|
  #     expect(rs).to have_key(:name)
  #     expect(rs).to have_key(:summary)
  #     expect(rs).to have_key(:platform)
  #     expect(rs).to have_key(:cover)
  #     expect(rs).to have_key(:first_release_date)
  #     expect(rs).to have_key(:genres)
  #     expect(rs).to have_key(:storyline)
  #   end
  # end
  
  # scenario "Showing a single gamecard detail when receiving ID" do
  #   id = 1877
  #   gamecard = gamesListProcess(id)
  #   expect(gamecard).not_to be_nil
  #   expect(gamecard).to have_key(:name)
  #   expect(gamecard).to have_key(:summary)
  #   expect(gamecard).to have_key(:platform)
  #   expect(gamecard).to have_key(:cover)
  #   expect(gamecard).to have_key(:first_release_date)
  #   expect(gamecard).to have_key(:genres)
  #   expect(gamecard).to have_key(:storyline)
  # end
  
  # scenario "Showing current latest news sortest by created date" do 
  #   time = (Time.current - 6.days).to_time.to_i
  #   fresh = (Time.current - 7.days).to_time.to_i
    
  #   news_result = gameLatestNewsRequest(time)
  #   expect(news_result).not_to be_nil
  #   news_result.each do |news|
  #     expect(news).to have_key(:author)
  #     expect(news).to have_key(:summary)
  #     expect(news).to have_key(:img)
  #     expect(news).to have_key(:created_at)
  #     convert_time = DateTime.strptime(news[:created_at], '%A-%d-%b-%Y-%R')

  #     puts convert_time
  #     expect(news[:created_at]).to be > DateTime.strptime(fresh.to_s,'%s').strftime("%A-%d-%b-%Y")
  #     expect(news).to have_key(:title)
  #     expect(news).to have_key(:url)
  #   end
  # end
  
  # scenario "Return Involved Companies IDs" do 
  #   companies = involvedCompaniesRequest(55090)
    
  #   expect(companies).not_to be_nil
  #   companies.each do |company|
  #     expect(company).to have_key(:id)
  #     expect(company).to have_key(:type)
  #   end
  # end
  
  # scenario "Showing Developers/Publisher on game id" do 
    
  #   publisher_detail = gameCompaniesRequest(55090,'Publisher')
  #   expect(publisher_detail).to have_key(:name)
  #   expect(publisher_detail).to have_key(:description)
  #   expect(publisher_detail).to have_key(:websites)
    
  #   developer_detail = gameCompaniesRequest(55090,'Developer')
  #   expect(developer_detail).to have_key(:name)
  #   expect(developer_detail).to have_key(:description)
  #   expect(developer_detail).to have_key(:websites)
    
  # end
  
  # scenario "Showing Latest Release games on platforms " do
  #   game_list_ps4 = gameRecentRelease('PlayStation')
  #   # game_list_xbox = gameRecentRelease('Microsoft Xbox')
  #   # game_list_pc = gameRecentRelease('PC')
  #   expect(game_list_ps4).not_to be_nil
  #   expect(game_list_ps4.first["platform"]).to eq(48)
  #   convert_time = DateTime.strptime(game_list_ps4.first["date"].to_s,'%s')
  #   expect(convert_time).to be_between(Time.now - 1.month,Time.now + 8.days).inclusive
  # end
  
  # it "build request" do
  #   uri = 'https://api-v3.igdb.com/games/'
  #   request = buildRequest(uri)
  #   expect(request).not_to be_nil
    
  #   # expect(response.status).to eq(404)
  # end
  
  it "get Platforms" do 
    gamesPlatformRequest
  end
end