# frozen_string_literal: true

Rails.application.routes.draw do
  # Configuration for sidekiq web
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  get 'games/countdown', to: 'games#countdown', as: 'countdown'
  get '/games/discover', to: 'games#discover', as: 'discover'
  
  scope '(:locale)', locale: /en|vi/ do
    root 'static_pages#home'
    get  '/news', to: 'static_pages#newsfeeds'
    get  '/help',    to: 'static_pages#help'
    get  '/about',   to: 'static_pages#about'
    get  '/contact', to: 'static_pages#contact'
    get '/hot', to: 'static_pages#hot'
    
    get '/signup', to: 'users#new'

    get 'games/newreleases', to: 'games#releases'
    get 'games/:id/guides', to: 'games#guides'
    get '/genres/', to: 'game_genre#show', as: 'game_genres'
    

    # PlatformsController
    get '/platforms/:id', to: 'platforms#show', as: 'platform'
    #get '/reviews', to: 'reviews#show'
    get '/search/', to: 'games#find', as: 'search'
    
  end
  
  resources :users
  resources :games
  resources :screenshots
  resources :game_videos
  resources :game_article_collections
  resources :game_articles
  resources :involved_companies

  resources :posts
end
