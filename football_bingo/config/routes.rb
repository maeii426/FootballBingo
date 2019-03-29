Rails.application.routes.draw do

  get  '/help' => 'static_pages#help'
  get  '/signup' => 'users#new'
  post '/signup' => 'users#create'
  get  '/share' => 'users#share'
  get    '/login' => 'sessions#new'
  post   '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  get '/score_board' => :score_board, controller: 'games'
  get '/game_play' => :game_play, controller: 'games'
  resources :users
  root 'static_pages#home'
  #root 'users#index'
end
