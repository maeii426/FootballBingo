Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get  '/help' => 'static_pages#help'
  get  '/signup' => 'users#new'
  post '/signup' => 'users#create'

  get    '/login' => 'sessions#new'
  post   '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  get '/score_board' => 'games#score_board'
  post '/send_email' => 'games#send_email'
  post '/check_win' => :check_win, controller: 'users'

  resources :users do
    get '/share' => 'users#share'
    resources :games do
      get '/play' => 'games#play_game'
      post '/join' => 'games#join'
      post '/get_new_card' => 'games#get_new_card'
      post '/get_whoop_card' => 'games#get_whoop_card'

    end
  end

  root 'static_pages#home'
  #root 'users#index'
  resources :games do
  end
end
