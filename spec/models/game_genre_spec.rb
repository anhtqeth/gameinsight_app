# == Schema Information
#
# Table name: game_genres
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  slug        :string
#  external_id :integer
#

require 'rails_helper'

RSpec.describe GameGenre, type: :model do
  subject {
    described_class.new(name: "Genres name", 
    description: "Description of the game genres")
  }
  
  it "is valid with valid attributes" do
    expect(subject).to be_valid 
  end
  
  
  it "is not valid without a name" do
    subject.name = nil
    expect(subject).to_not be_valid
  end
  
  it "is not valid without a description" do
    subject.description = nil
    expect(subject).to_not be_valid
  end
  
  it "can fetch API data" do 
    genres_list = subject.fetchAPIData
    puts genres_list
    expect(genres_list).not_to be_nil
  end
  
  it "can save API data" do
    before_count = GameGenre.count
    subject.saveAPIData
    expect(GameGenre.count).not_to eq(before_count)
  end
  
end
