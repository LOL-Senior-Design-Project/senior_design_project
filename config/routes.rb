Rails.application.routes.draw do

  get 'sessions/new'

  root 'static_pages#home'

  get 'static_pages/help'

  get 'static_pages/about'

  resources :users
  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
end
