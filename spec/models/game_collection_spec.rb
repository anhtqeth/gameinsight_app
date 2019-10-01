# == Schema Information
#
# Table name: game_collections
#
#  id          :bigint           not null, primary key
#  external_id :integer
#  name        :string
#  url         :string
#  description :text
#  game_id     :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe GameCollection, type: :model do
  subject {
    described_class.new(name: "Collection name",
    url: "url to collection",
    description: "Brief description on the collection")
    
  }
  
  it "is valid with valid attributes" do
     expect(subject).to be_valid
  end
  
  it "is not valid without a name" do
    subject.name = nil
    expect(subject).to_not be_valid
  end
  
  # it "is not valid without a game" do
  #   subject.game = nil
  #   expect(subject).to_not be_valid
  # end
  
  #Current Logic of API Request:
  #1. Get collection id from game api
  #2. get games list from gameSeriesRequest
  #3. Processed games list and shown.
  
  # it "can fetch collection from API" do 
  #   collection_id = 7331
  #   game_in_collection = subject.fetchAPIData(collection_id)
  #   expect(game_in_collection).not_to be_nil
  # end
  
  # it "can save API data" do 
  #   game_collection = GameCollection.new
  #   before_count = GameCollection.count
  #   game_collection.saveAPIData(7331)
  #   puts "COLLECTION SAVE DEBUG"
  #   puts game_collection.errors.messages
  #   expect(GameCollection.count).not_to eq(before_count)
  # end
  
  it "can get list of games from a collection" do
    games_list = subject.fetchGameCollection
    expect(games_list).not_to be_empty
  end
  
end


