require 'riot_api_helper'
class ChampionsController < ApplicationController
CHAMP_SQR = "http://ddragon.leagueoflegends.com/cdn/6.5.1/img/champion/"
    def cindex
        response = RIOT_API.new.get_champ
        @images = parse_champion(response)
    end
    
    def parse_champion(response)
        ar = Array.new
     response['data'].each do |key| 
         im = key[1]['image']['full']
         
         
         image = CHAMP_SQR + im
         ar << image 
     end
     
     return ar
    end
end
