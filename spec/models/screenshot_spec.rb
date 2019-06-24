require 'rails_helper'

RSpec.describe Screenshot, type: :model do
   subject {
    described_class.new(url: "Image URL",
    width: 1024,
    height: 768,
    game: Game.new())
  }
  
  it "is valid with valid attributes" do
    expect(subject).to be_valid 
  end
  
  it "is not valid without an url" do
    subject.url = nil
    expect(subject).to_not be_valid
  end
  
  it "is not valid without dimension" do
    subject.width = nil
    subject.height = nil
    expect(subject).to_not be_valid
  end
  
  it "can fetch APIData" do 
    game_screenshots = subject.fetchAPIData(19164)
    expect(game_screenshots).not_to be_nil
  end
  
  it "can save API Data" do
    before_count = Screenshot.count
    subject.saveAPIData(19164)
    expect(Screenshot.count).not_to eq(before_count)
  end 
  
  
end