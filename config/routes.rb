Rails.application.routes.draw do


  get 'users/new' => 'users#new'

  get 'sessions/new' => 'sessions#new'

  root 'static_pages#home'

  get 'help'  =>'static_pages#help'

  get 'about' =>'static_pages#about'
  
  get 'contact' =>'static_pages#contact'
  get 'summoners' => 'summoners#lookup'
  post 'summoners' => 'summoners#get_summoner'
  get 'stats' =>  'summoners#stats' 
  
  get 'champions' => 'champions#cindex'
  post 'champions' => 'champions#get_champion'
  # post 'stats' => 'summoners#get_champ_stats'
  #match "/get_summoner/", :controller => 'summoners',  :action => 'get_summoner'

  
  
  resources :users
  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  
 
  
end
