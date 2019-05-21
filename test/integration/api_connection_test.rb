require 'test_helper'
require 'net/http'
class ApiConnectionTest < ActionDispatch::IntegrationTest
include GamesApiModule
    
  test "getting game cover" do
    url = URI(COVER_URI)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    
    request = Net::HTTP::Get.new(url)
    request["user-key"] = USERKEY
    request.body = "fields *; where game = (#{gamesRequest.first['id']});"
    response http.request(request)
    result = JSON.parse(response.read_body)
  end
  
end
