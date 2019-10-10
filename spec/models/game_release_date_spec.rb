# frozen_string_literal: true

# == Schema Information
#
# Table name: game_release_dates
#
#  id                   :bigint           not null, primary key
#  date                 :date
#  game_id              :bigint
#  platform_id          :bigint
#  region               :integer
#  month                :integer
#  year                 :integer
#  date_format_category :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

require 'rails_helper'

RSpec.describe GameReleaseDate, type: :model do
  subject do
    described_class.new(date: DateTime.strptime(Time.now.to_s, '%s'),
                        game: Game.new, platform: Platform.new,
                        region: 1,
                        month: 2,
                        year: 2019,
                        date_format_category: 3)
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'can fetch API data ' do
    id = 55_090
    release_data = subject.fetchAPIData(id)
    puts 'RELEASE DATA'
    puts release_data
    expect(release_data).not_to be_nil
  end

  it 'can save API data ' do
    before_count = GameReleaseDate.count
    subject.saveAPIData(55_090)
    expect(GameReleaseDate.count).not_to eq(before_count)
  end
end
