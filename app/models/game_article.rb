# frozen_string_literal: true

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
require 'rss'
require 'open-uri'
require 'nokogiri'

class GameArticle < ApplicationRecord
  translates :title, :summary

  validates :url, :title, :news_source, :publish_at, presence: true
  belongs_to :game_article_collection, optional: true

  # HIGH PROFILE FEED
  GAMESPOT_NEWS_RSS_FEED = 'https://www.gamespot.com/feeds/news/'
  IGN_NEWS_RSS = 'http://feeds.ign.com/ign/news'
  GEMATSU_RSS = 'https://gematsu.com/feed'
  DESTRUCTOID_RSS = 'https://www.destructoid.com/index.phtml?t=ps4&mode=atom'
  PUSHSQUARE_RSS = 'http://www.pushsquare.com/feeds/latest'
  # Need to pick one
  EUROGAMER_RSS = 'https://www.eurogamer.net/rss'

  # OTHER PROFILE
  PUREPS_RSS = 'https://pureplaystation.com/feed/'
  SILICONERA_RSS = 'https://www.siliconera.com/feed/'

  # before_save :time_convert

  # protected
  # def time_convert
  #   puts 'DEBUG CONVERT'
  #   puts self.publish_at
  #   self.publish_at.to_time.to_i
  # end

  # TODO: Add uniqueness constraint
  def fetchAPIData(id)
    OpenStruct.new(gameArticleRequest(id))
  end

  def timeCoversion(time)
    DateTime.strptime(time, '%A-%d-%b-%Y')
  end

  def saveAPIData(api_article)
    game_article = GameArticle.new
    if api_article.nil?
      nil
    else
      game_article.external_id = api_article.id
      game_article.author      = api_article.author
      game_article.summary     = api_article.summary
      game_article.title       = api_article.title
      game_article.img         = api_article.img
      game_article.url         = api_article.url
      game_article.publish_at  = api_article.published_at
      game_article.news_source = api_article.news_source
      game_article.save
      puts '---DEBUG- ARTICLE SAVE ERRORS'
      puts game_article.errors.messages
      game_article
    end
  end

  # TODO: Currently filter out article with no img url. Need to have something to work with the nil ones.
  # TODO This is smell! It call request 2 times!
  def fetchLatestNews(time)
    latest_newsfeed = GameArticle.where('publish_at > ? AND img IS NOT NULL', time)
    if latest_newsfeed.empty?
      latest_newsfeed = gameLatestNewsRequest(time)
      # Save to DB
      latest_newsfeed.each do |api_article|
        saveAPIData(api_article)
      end
    end
    latest_newsfeed
  end

  # Get News Articles from RSS Feeds of other website
  # Input is the source name

  # Gamespot feed title,link,pubDate,description
  #
  def rssFeed(source)
    Rails.cache.fetch("#{source}/newsfeed", expires_in: 12.hours) do
      rss_feeds = nil
      # Depend on the request source. Getting corresponding newsfeed
      case source
      when 'gamespot'
        rss_feeds = RSS::Parser.parse(open(GAMESPOT_NEWS_RSS_FEED).read, false).items
      when 'ign'
        rss_feeds = RSS::Parser.parse(open(IGN_NEWS_RSS).read, false).items
      when 'gematsu'
        rss_feeds = RSS::Parser.parse(open(GEMATSU_RSS).read, false).items
      when 'destructoid'
        rss_feeds = RSS::Parser.parse(open(DESTRUCTOID_RSS).read, false).items
      when 'pushsquare'
        rss_feeds = RSS::Parser.parse(open(PUSHSQUARE_RSS).read, false).items
      end
      article_list = []
      # Processing feeds in readable format.
      rss_feeds.each do |r|
        # Used Nokogiri to parse the content
        parsed_html = Nokogiri::HTML.parse(r.description)
        # Get text content
        text = parsed_html.xpath '//p/text()'
        # Get feature image to article
        feature_img = if parsed_html.css('img').first.present?
                        parsed_html.css('img').first['src']
                      else
                        fetchImageFromURI(r.link, source)
                      end
        # feature_img = parsed_html.css('img').first['src'] if parsed_html.css('img').first.present?
        # Saved article to hash and add to array
        article = { title: r.title, url: r.link, source: nil,
                    publish_at: r.pubDate, summary: text.to_s, img: feature_img }
        article_list << article
      end

      article_list
    end
  end

  private

  def fetchImageFromURI(url, source)
    doc = Nokogiri::HTML(open(url))
    case source
    when 'gematsu'
      doc.css('img')[1]['src'] if doc.css('img')[1].present?
    when 'pushsquare'
      doc.css('img')[4]['src'] if doc.css('img')[4].present?
    end
  end
end
