class RIOT_API
    
LOL_URL = 'https://na.api.pvp.net'
KEY = 'api_key='
REGION= '/api/lol/na/'
SUMMONER = 'v1.4/summoner/by-name/'
SEASON = "season=SEASON2016"
CHAMPION = 'https://global.api.pvp.net/api/lol/static-data/na/v1.2/champion?champData=image&'+KEY + ENV["pusher_key"]

#23224192
    
    def get_summoner_id(name)        
        response = HTTParty.get(LOL_URL + REGION + SUMMONER + name + "?" +  KEY + ENV["pusher_key"])
        return response
        # method to get summoner id
    end
    
    def get_champImg(champ_id)
       response = HTTParty.get('https://global.api.pvp.net/api/lol/static-data/na/v1.2/champion/' + champ_id.to_s + '?champData=image&' + KEY + ENV["pusher_key"] )
       im = response['image']['full']
       return ime
    end
    

    # def champ_id(name)
       
    #   method to get champion id 
    # end
    def get_champ_stats(summonerID)
        return JSON.parse HTTParty.get(LOL_URL + REGION + 'v1.3/stats/by-summoner/' + summonerID + '/summary?'+SEASON+"&"+KEY+ ENV["pusher_key"]).response.body
    end

    def get_champ
        response = HTTParty.get(CHAMPION)
        return response
    end
    
    
    def recent_games(summonerID)
        return JSON.parse HTTParty.get(LOL_URL + REGION + 'v1.3/game/by-summoner/' + summonerID + '/recent?' + KEY + ENV["pusher_key"]).response.body
    end

    def get_map_name(given_id)
       response = HTTParty.get('https://global.api.pvp.net/api/lol/static-data/na/v1.2/map?'+ KEY + ENV["pusher_key"])
       response['data'].each do |map|
           map_id = map[1]['mapId']
           if map_id == given_id
               return map[1]['mapName']
           end
       end
       
       return "unknown"
    end
    
    def get_ranked_stat(given_id)
        response = HTTParty.get("https://na.api.pvp.net/api/lol/na/v1.3/stats/by-summoner/" + given_id + "/ranked?season=SEASON2016&" + KEY + ENV("pusher_key"))
        
        return response
    end
    # def getchamp
    #     response = HTTParty.get(CHAMPION)
    #     return response
    # endr
    
    # def get_champ_id(name)
    #     response = HTTParty.get(LOL_URL + '/api/lol/static')
    # end
end
