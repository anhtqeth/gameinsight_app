# frozen_string_literal: true

# == Schema Information
#
# Table name: game_videos
#
#  id          :bigint           not null, primary key
#  external_id :integer
#  url         :string
#  name        :string
#  description :text
#  game_id     :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe GameVideo, type: :model do
  subject do
    described_class.new(name: 'GamePlay Video',
                        url: 'Embeded Youtube URL',
                        description: 'Weapons Guide',
                        game: Game.new)
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without an url' do
    subject.url = nil
    expect(subject).to_not be_valid
  end

  it 'can fetch APIData' do
    game_videos = subject.fetchAPIData(19_164)
    expect(game_videos).not_to be_nil
  end

  it 'can save API Data' do
    before_count = GameVideo.count
    subject.saveAPIData(19_164)
    expect(GameVideo.count).not_to eq(before_count)
  end
end
