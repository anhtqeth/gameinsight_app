# == Schema Information
#
# Table name: game_articles
#
#  id                         :bigint           not null, primary key
#  external_id                :integer
#  author                     :string
#  summary                    :text
#  img                        :string
#  created_at                 :datetime         not null
#  title                      :string
#  url                        :string
#  news_source                :string
#  updated_at                 :datetime         not null
#  publish_at                 :integer
#  game_article_collection_id :bigint
#

require 'rails_helper'

RSpec.describe GameArticle, type: :model do
  subject {
    described_class.new(external_id: 1992,
    publish_at: 11231234,
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
  
  # it "is not valid without a author" do
  #   subject.author = nil
  #   expect(subject).to_not be_valid
  # end
  
  
  it "is not valid without an url" do
    subject.url = nil
    expect(subject).to_not be_valid
  end
  
  it "is not valid without a source name" do
    subject.news_source = nil
    expect(subject).to_not be_valid
  end
  
  it "is not valid without published_at column" do
    subject.publish_at = nil
    expect(subject).to_not be_valid
  end
  
  # it "can covert string to time" do
  #   time = "Tuesday-02-Jul-2019-00:00"
  #   expect(subject.timeCoversion(time)).to be_kind_of(DateTime)
  # end
  
  # it "can get article from api" do
  #   api_article = subject.fetchAPIData(781138)
  #   puts api_article
  #   expect(api_article).not_to be_nil
  # end
 
  # it "can fetch latest news from db" do
  #   time = (Time.current - 6.days).to_time.to_i
  #   news_feed = subject.fetchLatestNews(time)
  #   puts 'NEWS FEEDS'
  #   puts news_feed
  #   expect(news_feed).not_to be_empty
  # end
  
  it "fetch news from rss feed" do 
    gs_news = subject.rssFeed('gamespot')
    ign_news = subject.rssFeed('ign')
    gematsu_news = subject.rssFeed('gematsu')
    puts 'NEWS RSS FEED RESULT'
    puts gs_news.count
    puts gs_news.first
    
    expect(gs_news).not_to be_empty
  end
  
  

end
