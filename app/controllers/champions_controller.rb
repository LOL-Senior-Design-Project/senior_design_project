require 'riot_api_helper'
class ChampionsController < ApplicationController
CHAMP_SQR = "http://ddragon.leagueoflegends.com/cdn/6.9.1/img/champion/"
    def cindex
        response = RIOT_API.new.get_champ
        @champions = parse_champion(response)
    end
    
    def parse_champion(response)
        ar = Array.new
        response['data'].each do |key| 
         im = key[1]['image']['full']
         champ_name = key[1]['name']
         champ_title = key[1]['title']
         champ_image = CHAMP_SQR + im
         hash = { "name" => champ_name, "title" => champ_title, "image" => champ_image}
         ar << hash 
     end
     
     return ar
    end
end
