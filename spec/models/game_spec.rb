# frozen_string_literal: true

# == Schema Information
#
# Table name: games
#
#  id                 :bigint           not null, primary key
#  external_id        :integer
#  name               :string
#  summary            :text
#  storyline          :text
#  cover              :string
#  platform           :text             is an Array
#  genres             :string
#  first_release_date :date
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  popularity         :decimal(, )
#  slug               :string
#  game_collection_id :bigint
#

require 'rails_helper'

RSpec.describe Game, type: :model do
  subject do
    described_class.new(name: 'Game Name',
                        summary: 'A longer text. This is suppose to be a brief description of the current game',
                        storyline: 'A full details on the game story. Even longer than the above',
                        cover: 'An url of the cover image ', genres: 'Action RPG',
                        first_release_date: DateTime.now)
  end

  # it "is valid with valid attributes" do
  #   expect(subject).to be_valid
  # end

  # it "is not valid without a name" do
  #   subject.name = nil
  #   expect(subject).to_not be_valid
  # end

  # it "is not valid without a summary" do
  #   subject.summary = nil
  #   expect(subject).to_not be_valid
  # end

  # it "is not valid without a storyline" do
  #   subject.storyline = nil
  #   expect(subject).to_not be_valid
  # end

  # it "is not valid without a cover" do
  #   subject.cover = nil
  #   expect(subject).to_not be_valid
  # end

  # it "is not valid without a platforms" do
  #   subject.name = "Game Name"
  #   subject.summary = "Game Summary"
  #   subject.storyline = "A Long story"
  #   subject.cover = "an url to image"
  #   expect(subject).to_not be_valid
  # end

  # it "is not valid without a genres" do

  #   # subject.platforms = ["Stadia","Consoles"]
  #   subject.genres = nil
  #   expect(subject).to_not be_valid
  # end

  # it "is not valid without a release date" do
  #   subject.first_release_date = nil
  #   expect(subject).to_not be_valid
  # end

  # it "fetch data from api" do
  #   game = Game.new()
  #   details = game.fetchAPIData(55090)
  #   expect(details).not_to be_nil
  #   expect(details.name).not_to be_nil
  # end

  # it "save to db after api call" do
  #   #1877
  #   #80155 - with NA date
  #   game = Game.new
  #   before_count = Game.count
  #   # game.saveAPIData(80155)
  #   game.saveAPIData(26950)

  #   expect(Game.count).not_to eq(before_count)
  # end

  # it "can fetch latest release game base on platform" do
  #   #Default Time is set within 1 month
  #   latest_ps4_games = subject.fetchLatestRelease('PlayStation')
  #   latest_switch_games = subject.fetchLatestRelease('Nintendo Switch')
  #   puts latest_ps4_games
  #   puts latest_switch_games
  #   expect(latest_ps4_games).not_to be_empty
  #   expect(latest_switch_games).not_to be_empty
  # end

  # it "can fetch popular game base on platform" do
  #   #Default Time is set within 1 month
  #   latest_ps4_games = subject.fetchPopularGamebyPlatform('PlayStation 4')
  #   latest_switch_games = subject.fetchPopularGamebyPlatform('Nintendo Switch')
  #   puts latest_ps4_games
  #   puts latest_switch_games
  #   expect(latest_ps4_games).not_to be_empty
  #   expect(latest_switch_games).not_to be_empty
  # end

  # it "can fetch upcoming release base on time" do
  #   time = Date.today.at_beginning_of_month.next_month
  #   time = Date.parse(time.to_s)
  # end

  it 'can find game from api' do
    name = 'Devil'
    rs = subject.findApiGames(name)
    expect(rs).not_to be_empty
    expect(rs.first.name).to include('Devil ')
    puts rs
  end

  # it "can search from api if no data" do
  #   name = "God"
  #   rs = subject.findApiGames(name)
  #   expect(rs).not_to be_empty
  #   expect(rs.first.name).to include("God")
  # end
end
