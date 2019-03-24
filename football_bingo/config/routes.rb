Rails.application.routes.draw do

  get  '/help',    to: 'static_pages#help'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get  '/share',  to: 'users#share'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/score_board', to: :score_board, controller: 'games'
  resources :users
  root 'static_pages#home'
  #root 'users#index'
end
