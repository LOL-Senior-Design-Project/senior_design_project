class RIOT_API

LOL_URL = 'https://na.api.pvp.net'
KEY = '?api_key='
REGION= '/api/lol/na/'
SUMMONER = 'v1.4/summoner/by-name/'
CHAMPION = 'https://global.api.pvp.net/api/lol/static-data/na/v1.2/champion?champData=all&'
    
    def get_summoner_id(name)
        response = HTTParty.get(LOL_URL + REGION + SUMMONER + name +  KEY + ENV["pusher_key"])
        return response
        # method to get summoner id
    end
    # def champ_id(name)
       
    #   method to get champion id 
    # end
    def get_champ_stats(champId)
        response = HTTParty.get(LOL_URL + REGION + 'stats/by-summoner/' + champId + '/summary')
        return response
    end
end
