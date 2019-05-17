require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "Home | Welcome to GameInsight"
  end

  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title", "Help | GameInsight FAQ"
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "About | About GameInsight"
  end

  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", "Contact | Get in Touch!"
  end

end
