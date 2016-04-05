class ChampionsController < ApplicationController
CHAMP_SQR = "http://ddragon.leagueoflegends.com/cdn/6.5.1/img/champion/"
    def get_champion
        response = RIOT_API.new.get_champ
        @champions = response['data']
        byebug
      
        # for i in 0..@champions.length
        #     champ_id = @champions[i]['id']
        #     champ_title = @champions[i]['title']
        #     champ_name = @champions[i]['name']
        #     champ_key = @champions[i]['key']
        #     champ_img = CHAMP_SQR + champ_name + '.png'
        # end
        render 'cindex'
        
    end
end
