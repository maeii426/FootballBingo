Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get  '/help' => 'static_pages#help'
  get  '/signup' => 'users#new'
  post '/signup' => 'users#create'
  get  '/share' => 'users#share'
  get    '/login' => 'sessions#new'
  post   '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  get '/score_board' => :score_board, controller: 'games'
  get '/send_email' => :send_email, controller: 'games'
  get '/check_win' => :check_win, controller: 'users'
  get '/game_stats' => 'games#stats'
  #get '/active_card' => :user_cards, controller: 'cards'
  resources :users
  root 'static_pages#home'
  #root 'users#index'
end
