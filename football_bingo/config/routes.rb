FootballBingo::Application.routes.draw do
  
  root 'accounts#login'
  get 'home/index'
  
end
