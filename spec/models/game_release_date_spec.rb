require 'rails_helper'

RSpec.describe GameReleaseDate, type: :model do
  subject {
    described_class.new(date: DateTime.strptime(Time.now.to_s,'%s'),
    game: Game.new,platform: Platform.new,
    region: 1,
    month: 2,
    year: 2019,
    date_format_category: 3)
  }
  
  
  it "is valid with valid attributes" do
    expect(subject).to be_valid 
  end
  
  it  "can fetch API data " do 
    id = 55090
    release_data = subject.fetchAPIData(id)
    puts 'RELEASE DATA'
    puts release_data
    expect(release_data).not_to be_nil
  end
  
  it "can save API data " do
    before_count = GameReleaseDate.count
    subject.saveAPIData(55090)
    expect(GameReleaseDate.count).not_to eq(before_count)
  end
  
end
