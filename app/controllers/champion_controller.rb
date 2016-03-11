class ChampionController < ApplicationController
    
#     def get_champion
#      if params[:champion_name] == " "
#         flash[:error] = "Champion name cannot be blank"
#         render 'lookup'
#     else 
#          response = RIOT_API.new.get_summoner_id(params[:summoner_name])
#          if(response.include? ("error"))
#           flash[:error] = "Something went wrong and Riot Games is not responding. Please try again later."
#           render 'lookup'
#          else
#             @stats = parse_response(response)
#             flash[:error] = "what went wrong?"
#             render 'stats'
#         end
#     end
      
#   end

    
#     def parse_response(response)
#         screen_name = response.first[1]['name']
#         id = response.first[1]['id']
#         level = response.first[1]['summonerLevel']
#         icon = PROFILE_ICON + response.first[1]["profileIconId"].to_s + '.png'

#     return {screen_name: screen_name, id: id, level: level, icon: icon}
#   end

end
