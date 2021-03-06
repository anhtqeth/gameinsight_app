# frozen_string_literal: true

# == Schema Information
#
# Table name: game_article_collections
#
#  id              :bigint           not null, primary key
#  external_id     :integer
#  name            :string
#  game_id         :bigint
#  game_article_id :bigint
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe GameArticleCollection, type: :model do
  subject do
    described_class.new(external_id: 1,
                        game: Game.new,
                        name: 'Collection News')
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'can fetch API data ' do
    id = 19_164
    article_collection = subject.fetchAPIData(id)
    puts 'NEWS DATA'
    puts article_collection
    expect(article_collection).not_to be_nil
  end

  it 'can save API data ' do
    before_count = GameArticleCollection.count
    subject.saveAPIData(19_164)
    expect(GameArticleCollection.count).not_to eq(before_count)
  end
end
