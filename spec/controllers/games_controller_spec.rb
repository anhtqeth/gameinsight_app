# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe '#game' do
    
  end
  
  describe "PUT update/:id" do
    @game = Game.new
    @game.id = 1
    @game.summary = 'Summary'
    @game.storyline = 'Storyline'
    @game.save
    let(:attr) do 
      { :summary => 'This is a new Summary', :storyline => 'This is a new story' }
    end
  
    before(:each) do
      put :update, :id => @game.id, :game => attr
      @game.reload
    end
  
    it { expect(response).to redirect_to(@game) }
    it { expect(@game.summary).to eql attr[:summary] }
    it { expect(@game.storyline).to eql attr[:storyline] }
  end
end
