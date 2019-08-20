require 'rails_helper'

RSpec.describe InvolvedCompany, type: :model do
  subject {described_class.new( game: Game.new,
    company: Company.new)}
    
  it "is valid with valid attributes" do
    expect(subject).to be_valid 
  end
  
  it "can find company name" do 
    game_id = 13
    
    publisher = subject.findCompany(game_id,'Publisher')
    #developer = subject.findCompany(game_id,'Developer')
    
    expect(publisher).not_to be_nil
    #expect(developer).not_to be_nil
    expect(publisher.name).not_to be_nil
    expect(developer.name).not_to be_nil
  end
  
  
end
