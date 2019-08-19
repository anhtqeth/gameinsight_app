require 'rails_helper'
include GamesHelper
# Specs in this file have access to a helper object that includes
# the GameGenreHelper. For example:
#
# describe GameGenreHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe GamesHelper, type: :helper do
  
  describe "check if data is nil" do 
    it "has data" do
      newsfeed = GameArticleCollection.where(game_id: 11).take
      puts newsfeed
      data = newsfeed.game_articles
      
      result = game_newsfeed(data)
      expect(result).to have_tag('div')
    end
    
    it "has no data" do 
      data = nil
      result = game_newsfeed(data)
      expect(result).to include("We found no news source related to this game yet. 
      Do you have ones? Consider contributing it!")
    end
  end
  
  describe "render media newsfeed" do
    it "render newsfeed correctly" do
      
    end
    
    
  end
end
