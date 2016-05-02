require 'riot_api_helper'
class SummonersController < ApplicationController
  PROFILE_ICON = 'http://ddragon.leagueoflegends.com/cdn/6.5.1/img/profileicon/'
  CHAMP_SQR = "http://ddragon.leagueoflegends.com/cdn/6.5.1/img/champion/"
  ITEM_SQR = "http://ddragon.leagueoflegends.com/cdn/6.8.1/img/item/"

  

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
    unless params[:summoner_name].present?
        flash[:error] = "Summoner name cannot be blank"
        render 'lookup'
    else 
        response = RIOT_API.new.get_summoner_id(params[:summoner_name])
        if(parse_response(response).include?('status_code'))
           flash[:error] = "Please Try Again"
           render 'lookup'
        else
            @summoner = parse_response(response)
            @stats = recent_game_stats
            
            render 'stats'
        end
    end
      
  end
  
  def recent_game_stats
    game = RIOT_API.new.recent_games(@summoner[:id].to_s)
     
    # if (h["playerStatSummaries"].present?)
    #   ranked_array = Array.new
      
    #   for i in 0...h["playerStatSummaries"].length
    #     arr = Hash.new
    #     arr[:name] = h["playerStatSummaries"][i]["playerStatSummaryType"]
    #     arr[:value] = h["playerStatSummaries"][i]["wins"]
    #     # arr[key] = val
    #     return_arr << arr
      
    #   end
    # else
      
    # end
    
    if(game['games'].present?)
      stat_ar = Array.new
      item_ar = Array.new
  
      for i in 0...game['games'].length
        im = RIOT_API.new.get_champImg(game['games'][i]['championId'])
        image = CHAMP_SQR + im
        game_id = game['games'][i]['gameId']
        game_mode = game['games'][i]['gameMode']
        game_type = game['games'][i]['gameType']
        map = RIOT_API.new.get_map_name(game['games'][i]['mapId'])
        #lookup map id and return which map it is
        if game['games'][i]['stats']['win'].equal?(true)
          win = "Victory"
        else 
          win = "Defeat"
        end
        date = game['games'][i]['createDate']
        fellowPlayers = game['games'][i]['fellowPlayers']
        ip_earned = game['games'][i]['ipEarned']
        team_color = game['games'][i]['teamId']
        #stats = game['games'][i]['stats']
        play_time = game['games'][i]['stats']['timePlayed']
        kills = game['games'][i]['stats']['championsKilled']
        if !kills.present?
          kills =0
        end
        deaths = game['games'][i]['stats']['numDeaths']
        if !deaths.present?
          deaths =0
        end
        assist = game['games'][i]['stats']['assists']
        if !assist.present?
          assist =0
        end
        item0 = ""
        unless(game['games'][i]['stats']['item0'].to_s.empty?)
          item0 = ITEM_SQR + game['games'][i]['stats']['item0'].to_s
          item0 = item0 + ".png"
        end
        item1 = ""
        unless(game['games'][i]['stats']['item1'].to_s.empty?)
          item1 = ITEM_SQR + game['games'][i]['stats']['item1'].to_s
          item1 = item1 + ".png"
        end
        item2 = ""
        unless(game['games'][i]['stats']['item2'].to_s.empty?)
        item2 = ITEM_SQR + game['games'][i]['stats']['item2'].to_s
          item2 = item2 + ".png"
        end
        item3 = ""
         unless(game['games'][i]['stats']['item3'].to_s.empty?)
                 item3 = ITEM_SQR + game['games'][i]['stats']['item3'].to_s

          item3 = item3 + ".png"
        end
        item4 = ""
        unless(game['games'][i]['stats']['item4'].to_s.empty?)
                item4 = ITEM_SQR + game['games'][i]['stats']['item4'].to_s

          item4 = item4 + ".png"
        end
        item5 = ""
        unless(game['games'][i]['stats']['item5'].to_s.empty?)
                item5 = ITEM_SQR + game['games'][i]['stats']['item5'].to_s

          item5 = item5 + ".png"
        end
        item6 = ""
        unless(game['games'][i]['stats']['item6'].to_s.empty?)
                item6 = ITEM_SQR + game['games'][i]['stats']['item6'].to_s

          item6 = item6 + ".png"
        end
        
        hash = {"g_img" => image, "g_id" => game_id, "g_mode" => game_mode, "g_type" => game_type,"g_map" => map, "g_win" => win, "g_date" => date, "g_players" => fellowPlayers, "g_ip" => ip_earned, "g_color" => team_color, "g_playTime" => play_time, "g_kills" => kills, "g_deaths" => deaths, "g_assists" => assist,"g_i0" => item0, "g_i1" => item1, "g_i2" => item2, "g_i3" => item3, "g_i4" => item4, "g_i5" => item5, "g_i6" => item6}
        stat_ar << hash
      end
      return stat_ar
      
    else \
    end
    
  end
        
        
    
  def game_type_wins
    h = RIOT_API.new.get_champ_stats(@summoner[:id].to_s)
    # wins =0
    # losses=0
    if (h["playerStatSummaries"].present?)
      return_arr = Array.new
      
      for i in 0...h["playerStatSummaries"].length
        arr = Hash.new
        arr[:name] = h["playerStatSummaries"][i]["playerStatSummaryType"]
        wins= h["playerStatSummaries"][i]["wins"].to_f
        losses= h["playerStatSummaries"][i]["losses"].to_f
        arr[:value] = wins
        (arr[:value] = (((wins / (wins+losses).to_f).to_f)*100).to_f) unless wins==0
        # arr[key] = val
        return_arr << arr
      
      end
      return return_arr.to_json
    else 
      return []
    end
  end
  
  helper_method :game_type_wins

  def test_func
    return [1,3,2,5,9]
    # return "it works!"

  end

  helper_method :test_func 

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
  
  def get_rankedChamps(summoner_id)
    stats = RIOT_API.new.get_ranked_stat(summoner_id)
    stats['champions'].each do |champ|
      id = champ['id']
      sessions_played = champ['id']['totalSessionsPlayed']
      wins = champ['id']['totalSessionsWon']
      losses = champ['id']['totalSessionsLost']
    end
  end
  

end
