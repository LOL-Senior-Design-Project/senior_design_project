class RIOT_API
    
LOL_URL = 'https://na.api.pvp.net'
KEY = 'api_key='
REGION= '/api/lol/na/'
SUMMONER = 'v1.4/summoner/by-name/'
SEASON = "season=SEASON2016"
<<<<<<< HEAD
CHAMPION = 'https://global.api.pvp.net/api/lol/static-data/na/v1.2/champion?champData=image&'+KEY + ENV["pusher_key"]
=======
# CHAMPION = 'https://global.api.pvp.net/api/lol/static-data/na/v1.2/champion'+KEY + ENV["pusher_key"]
CHAMPION = 'https://global.api.pvp.net/api/lol/static-data/na/v1.2/champion'+KEY + "fee99c75-dcea-4b6b-948f-bf32b93feb81"
>>>>>>> df4573d53b1ccdb8e775f31a505ca5e89a51d276

    
    def get_summoner_id(name)        # response = HTTParty.get(LOL_URL + REGION + SUMMONER + name + "?" +  KEY + ENV["pusher_key"])
        response = HTTParty.get(LOL_URL + REGION + SUMMONER + name + "?" +  KEY + ENV["pusher_key"])
        return response
        # method to get summoner id
    end

    # def champ_id(name)
       
    #   method to get champion id 
    # end
    def get_champ_stats(summonerID)
        # response = HTTParty.get(LOL_URL + REGION + 'v1.3/stats/by-summoner/' + summonerID + '/summary?'+SEASON+"&"+KEY+ "fee99c75-dcea-4b6b-948f-bf32b93feb81")
        # return response

        return JSON.parse HTTParty.get(LOL_URL + REGION + 'v1.3/stats/by-summoner/' + summonerID + '/summary?'+SEASON+"&"+KEY+ "fee99c75-dcea-4b6b-948f-bf32b93feb81").response.body
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
