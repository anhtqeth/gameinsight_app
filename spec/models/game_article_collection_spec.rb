require 'rails_helper'

RSpec.describe GameArticleCollection, type: :model do
  subject {
    described_class.new(external_id: 1,
    game: Game.new,game_article: GameArticle.new,
    name: "Collection News")
  }
  
  
  it "is valid with valid attributes" do
    expect(subject).to be_valid 
  end
  
  it  "can fetch API data " do 
    id = 55090
    article_collection = subject.fetchAPIData(id)
    puts 'NEWS DATA'
    puts article_collection
    expect(article_collection).not_to be_nil
  end
  
  it "can save API data " do
    before_count = GameArticleCollection.count
    subject.saveAPIData(55090)
    expect(GameArticleCollection.count).not_to eq(before_count)
  end
end
