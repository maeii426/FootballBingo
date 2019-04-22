Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get  '/help' => 'static_pages#help'
  get  '/signup' => 'users#new'
  post '/signup' => 'users#create'
  get  '/share' => 'users#share'
  get    '/login' => 'sessions#new'
  post   '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  get '/score_board' => 'games#score_board'
  get '/send_email' => 'games#send_email'
  get '/check_win' => 'users#check_win'
  #get '/active_card' => :user_cards, controller: 'cards'

  resources :users do
    resources :games do
      get '/play' => 'games#play_game'
      get '/join' => 'games#join'
      get '/get_new_card' => 'games#get_new_card'
    end
  end

  root 'static_pages#home'
  #root 'users#index'
  resources :games do
  end
end
