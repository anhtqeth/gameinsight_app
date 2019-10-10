# frozen_string_literal: true

# == Schema Information
#
# Table name: screenshots
#
#  id          :bigint           not null, primary key
#  external_id :integer
#  url         :string
#  width       :integer
#  height      :integer
#  game_id     :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Screenshot, type: :model do
  subject do
    described_class.new(url: 'Image URL',
                        width: 1024,
                        height: 768,
                        game: Game.new)
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without an url' do
    subject.url = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without dimension' do
    subject.width = nil
    subject.height = nil
    expect(subject).to_not be_valid
  end

  it 'can fetch APIData' do
    game_screenshots = subject.fetchAPIData(19_164)
    expect(game_screenshots).not_to be_nil
  end

  it 'can save API Data' do
    before_count = Screenshot.count
    subject.saveAPIData(19_164)
    expect(Screenshot.count).not_to eq(before_count)
  end
end
