# frozen_string_literal: true

# == Schema Information
#
# Table name: platforms
#
#  id            :bigint           not null, primary key
#  external_id   :integer
#  abbreviation  :string
#  alt_name      :string
#  generation    :integer
#  name          :string
#  platform_logo :string
#  summary       :text
#  details       :text
#  url           :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  slug          :string
#

require 'rails_helper'

RSpec.describe Platform, type: :model do
  subject do
    described_class.new(name: 'Platform name',
                        abbreviation: 'A longer text. This is suppose to be a brief description of the current game',
                        alt_name: 'Another name for this platform',
                        platform_logo: 'An icon of the platform', summary: 'Short info ', generation: 8,
                        details: 'More info like spec, history and other', url: 'url to main manufacturer')
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a summary' do
    subject.summary = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without generation' do
    subject.generation = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a abbreviation' do
    subject.abbreviation = nil
    expect(subject).to_not be_valid
  end

  it 'can fetch API data' do
    platform_id = 48
    platform_details = subject.fetchAPIData(platform_id)
    puts platform_details
    expect(platform_details).not_to be_nil
  end

  it 'can save API data' do
    before_count = Platform.count
    subject.saveAPIData(48)
    expect(Platform.count).not_to eq(before_count)
  end
end
