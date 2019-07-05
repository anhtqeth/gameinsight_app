require 'rails_helper'

RSpec.describe GameArticle, type: :model do
  subject {
    described_class.new(external_id: 1992,
    author: "Article Author",
    summary: "Summary of Article",
    img: "Article Image URL",
    title: "Article Title",
    url: "Article URL",
    news_source: "EthuGamer")
  }
  
  it "is valid with valid attributes" do
    expect(subject).to be_valid 
  end
  
    it "is not valid without a title" do
    subject.title = nil
    expect(subject).to_not be_valid
  end
  
  it "is not valid without a author" do
    subject.author = nil
    expect(subject).to_not be_valid
  end
  
  
  it "is not valid without an url" do
    subject.url = nil
    expect(subject).to_not be_valid
  end
  
  it "is not valid without a source name" do
    subject.news_source = nil
    expect(subject).to_not be_valid
  end
  
  # it "can fetch latest News from API" do 
  #   time = (Time.current - 6.days).to_time.to_i
  #   game_article = subject.fetchAPILatestNews(time)
  #   expect(game_article).not_to be_nil
  #   expect(game_article.first[:created_at]).to be >  time
  # end
  
  # it "can covert string to time" do
  #   time = "Tuesday-02-Jul-2019-00:00"
  #   expect(subject.timeCoversion(time)).to be_kind_of(DateTime)
  # end
  
  # it "can get article from api" do
  #   api_article = subject.fetchAPIData(781138)
  #   puts api_article
  #   expect(api_article).not_to be_nil
  # end
  
  it "can save lates news Data" do
    before_count = GameArticle.count
     
    subject.saveAPIData(781138)
    expect(GameArticle.count).not_to eq(before_count)
   
  end 
  
  # it "can format News Souce name" do
  #   news_source_list = ["gamespot","siliconera","vgr","kotaku","gamesindustry","twinfinite"]
    
  # end
    
end
