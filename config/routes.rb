# frozen_string_literal: true

Rails.application.routes.draw do
  resources :styles
  resources :memberships
  resources :beer_clubs
  resources :users
  resources :beers
  resources :breweries
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'breweries#index'
  # get 'ratings', to: 'ratings#index'
  # get 'ratings/new', to:'ratings#new'
  # post 'ratings', to: 'ratings#create'

  resources :breweries do
    post 'toggle_activity', on: :member
  end

  resources :users do
    post 'toggle_activity', on: :member
  end

  get 'signup', to: 'users#new'
  resources :ratings, only: %i[index new create destroy]

  resource :session, only: [:new, :create, :destroy]
  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'
  delete 'signout_and_destroy', to: 'sessions#megadeth'

  resources :places, only: [:index, :show]
  resources :weathers, only: [:index, :show]
  # mikä generoi samat polut kuin seuraavat kaksi
  # get 'places', to:'places#index'
  # get 'places/:id', to:'places#show'
  
  post 'places', to:'places#search'

  get 'beerlist', to:'beers#list'
  get 'brewerylist', to:'breweries#list'
end
