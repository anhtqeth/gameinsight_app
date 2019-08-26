Rails.application.routes.draw do
  
  root 'static_pages#home'

  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get '/release_by_platform', to: 'static_pages#latest_releases', as: 'release'
  
  get  '/signup',  to: 'user#new'
  
  #GamesController
  get '/games/:id', to: 'games#show', as: 'game'
  get 'games/new-releases', to: 'games#newrelease'
  get 'games/:id/guides', to: 'games#guides'
  
  get '/genres/', to: 'game_genre#show', as: 'game_genres'
  
  get '/hot', to: 'static_pages#hot'
  get '/discover', to: 'games#discover'
  
  #PlatformsController
  get '/platforms/:id', to: 'platforms#show', as: 'platform'
  
  #??Controller
  get '/reviews', to: 'reviews#show'
  
  get '/search/', to: 'games#find', as: 'search'
  
end
