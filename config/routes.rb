Rails.application.routes.draw do
  
  root 'static_pages#home'

  get  '/help',    to: 'static_pages#help'
  
  get  '/about',   to: 'static_pages#about'
  
  get  '/contact', to: 'static_pages#contact'
  
  get  '/signup',  to: 'user#new'
  
  get '/games/:id', to: 'games#show', as: 'game'

  get '/search/', to: 'games#find', as: 'search'
  
  get '/release_by_platform', to: 'static_pages#latest_releases', as: 'release'
  
  get '/game_genres/', to: 'game_genre#show', as: 'game_genres'
  

end
