class RIOT_API
    
LOL_URL = 'https://na.api.pvp.net'
KEY = 'api_key='
REGION= '/api/lol/na/'
SUMMONER = 'v1.4/summoner/by-name/'
SEASON = "season=SEASON2016"
CHAMPION = 'https://global.api.pvp.net/api/lol/static-data/na/v1.2/champion?champData=image&'+KEY + ENV["pusher_key"]

    
    def get_summoner_id(name)        
        response = HTTParty.get(LOL_URL + REGION + SUMMONER + name + "?" +  KEY + ENV["pusher_key"])
        return response
        # method to get summoner id
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
    

    # def getchamp
    #     response = HTTParty.get(CHAMPION)
    #     return response
    # end
    
    # def get_champ_id(name)
    #     response = HTTParty.get(LOL_URL + '/api/lol/static')
    # end
end
