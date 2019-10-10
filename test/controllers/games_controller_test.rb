# frozen_string_literal: true

require 'test_helper'

class GamesControllerTest < ActionDispatch::IntegrationTest
  test 'Showing Game Details Page' do
    get '/games/2269'

    assert_response :success, 'Not Right'
  end
end
