require 'rails_helper'
include GamesHelper
#include ActionView::Helpers::AssetTagHelper
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
      # newsfeed = GameArticleCollection.where(game_id: 11).take
      # puts newsfeed
      # data = newsfeed.game_articles
      
      # result = game_newsfeed(data)
      # expect(result).to have_tag('div')
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
  
  describe "render media carousel" do
    it "can create new carousel" do 
      
    end
    
    it "can build media array" do 
      # game = Game.new
      # data = game.fetchPopularUpcomingRelease
      # result = getMediaUrl(data,'img')
      # puts result
      # expect(result).not_to be_nil
    end
    
    it "can render carousel items" do 
      # carousel = Carousel.new
      # game = Game.find(13)
      
      # media_data = []
      # game.screenshots.each do |media|
      #   media_data << media.url
      # end
      # carousel.carousel_item(media_data)
      # putscarousel.carousel_item(media_data)
      
    end
    
    it "can return a desire format date" do 
      time = Time.now
      puts "Time input #{time}"
      expect(date_format(time)).not_to be_nil
      puts "Time output #{date_format(time)}"
    end
    
    it "can render badge" do 
      time = Time.now
      puts "Time input #{time}"
      expect(date_format(time)).not_to be_nil
      puts "Time output #{date_format(time)}"
    end
    
  end
end
