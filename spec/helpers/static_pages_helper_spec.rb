require 'rails_helper'
include StaticPagesHelper


RSpec.describe StaticPagesHelper, type: :helper do
  
  describe "check if data is nil" do 
    it "has no data" do 
      data = nil
      result = platform_selection(data)
      expect(result).to include("Cannot processed with nil result")
    end
    
  end
  
  describe "render latest platform only" do 
    it "contain only 4 popular platform" do
      data = ['PlayStation 4','PC (Microsoft Windows)','Nintendo Switch','Xbox One']
      result = platform_selection(data)
      puts result
      expect(result).to include('PlayStation 4')
    end
  
  end
  
  
end
