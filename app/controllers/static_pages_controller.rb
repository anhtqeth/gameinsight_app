require 'uri'
require 'net/http'
class StaticPagesController < ApplicationController
  
  $release_date_uri = 'https://api-v3.igdb.com/release_dates/';
  @game_url = "https://api-v3.igdb.com/games/";
  $cover_uri = 'https://api-v3.igdb.com/covers';
  $art_uri = 'https://api-v3.igdb.com/artworks';
  $screenshots_uri = 'https://api-v3.igdb.com/screenshots';
  
  #Current userkey for IGDB Request
 
  @unix_time = Time.current.to_time.to_i;
# request_headers = { headers: { 'user-key' => $user_key } }
    # #rawBody = 'fields *; where game = ';
    # api = Apicalypse.new(game_uri, request_headers)
    # @result = api.fields(:id).where(category: 1).search('Yakuza 0').limit(2).request
  def home
    url = URI("https://api-v3.igdb.com/games/")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(url)
    request["user-key"] = 'ada77f859e3e4c235b5b6e360c79e249'
    request.body = 'fields summary; where name = "Yakuza 0";'
    response = http.request(request)
    result = JSON.parse(puts response.read_body)
    @summary = result['']['summary']
  end

  def help
  end

  def about
  end

  def contact
  end
end
