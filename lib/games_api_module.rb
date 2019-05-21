module GamesApiModule
      def gamesRequest
        @game_url = "https://api-v3.igdb.com/games/";
        @cover_uri = 'https://api-v3.igdb.com/covers';
        @art_uri = 'https://api-v3.igdb.com/artworks';
        @screenshots_uri = 'https://api-v3.igdb.com/screenshots';
        @userkey = 'ada77f859e3e4c235b5b6e360c79e249';
        @unix_time = Time.current.to_time.to_i;
        
        @http = Net::HTTP.new(url.host, url.port)
        @http.use_ssl = true
        @http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        
        url = URI(@game_url)
       
        request = Net::HTTP::Get.new(url)
        request["user-key"] = @userkey
        request.body = 'fields *; where name = "Yakuza 0";'
        response = @http.request(request)
        result = JSON.parse(response.read_body)
        result.first['summary']
      end
    
      def releaseDate
        
      end
      
      def gameDetails
        
      end
      
      def gameCoverArt
        
      
      end
end