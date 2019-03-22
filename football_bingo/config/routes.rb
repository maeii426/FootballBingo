Rails.application.routes.draw do

  get  '/help',    to: 'static_pages#help'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'

  resources :users
  root 'static_pages#home'
  #root 'users#index'
end
