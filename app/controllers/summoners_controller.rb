require 'riot_api_helper'
class SummonersController < ApplicationController
  PROFILE_ICON = 'http://ddragon.leagueoflegends.com/cdn/6.5.1/img/profileicon/'

  def stats
  
  end


  def new
    @summoner = Summoner.new
  end

  def create
    @summoner = Summoner.new(summoner_params)
    if @summoner.save
      log_in @summoner
      flash[:sucess] = "Welcome to the Address Book App"
      redirect_to @summoner
    else
      render 'new'
    end
  end
  
  def get_summoner
    if params[:summoner_name].empty?
        flash[:error] = "Summoner name cannot be blank"
        render 'lookup'
    else 
        response = RIOT_API.new.get_summoner_id(params[:summoner_name])
        if(parse_response(response).include?('status_code'))
           flash[:error] = "Please Try Again"
           render 'lookup'
        else
            @summoner = parse_response(response)
            render 'stats'
        end
    end
      
  end
  def get_win_rate_for_game_type
    h = RIOT_API.new.get_champ_stats(:summoner_id)
    arr = Hash.new
    for i in 0...h["playerStatSummaries"].length
      key = h["playerStatSummaries"][i]["playerStatSummaryType"]
      val = h["playerStatSummaries"][i]["wins"]
      arr[key] = val
    end
    return arr
  end


  def get_stats
     response = RIOT_API.new.get_champ_stats(:summoner_id,'SEASON2016') 
     @stats = response
  end
    
    def parse_response(response)
        # if response.code(("400")|| ("401")||("404")||("415")||("429")||("500")||("503"))
        #     return {status: status_code}
        # end
        screen_name = response.first[1]['name']
        id = response.first[1]['id']
        level = response.first[1]['summonerLevel']
        icon = PROFILE_ICON + response.first[1]["profileIconId"].to_s + '.png'

    return {screen_name: screen_name, id: id, level: level, icon: icon}
  end
  
    def parse_stats(response)
    
    end

end
