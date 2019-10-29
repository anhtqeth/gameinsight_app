# frozen_string_literal: true
require 'spec_helper'
require 'rails_helper'

RSpec.feature 'Translate Games Text', type: :feature do
  include TranslationModule
  
  it 'translate single text base with source and target' do
    cn_text = transText('This is a game','en','zh')
    jp_text = transText('This is a game','en','ja')
    vi_text = transText('This is a game','en','vi')
    kor_text = transText('This is a game','en','ko')
    
    puts cn_text
    puts jp_text
    puts vi_text
    puts kor_text
    
    expect(cn_text).to be_instance_of(String)
    expect(cn_text).not_to be_nil
    expect(jp_text).not_to be_nil
    expect(vi_text).not_to be_nil
  end
  
  it 'translate a game model' do
    game = Game.new
    game.summary   = 'This is the description of the game'
    game.storyline = 'This is the storyline of the game'
    game.save
    gameDetailTrans(game,'en','vi')
    I18n.locale = :vi
    puts game.summary
    puts game.storyline
    expect(game.summary).not_to be_nil
  end
  
  
end
