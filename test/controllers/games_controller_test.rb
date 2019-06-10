require 'test_helper'

class GamesControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  test "Getting Game Details" do
    game_details = GamesController.show
    
    assert_not_nil game_details
  end
  
end
