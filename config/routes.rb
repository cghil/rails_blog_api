require 'api_constraints'

MarketPlaceApi::Application.routes.draw do
devise_for :users
  # Api definition
  namespace :api do
    namespace :v1 do
      # We are going to list our resources here
      resources :users, :only => [:show, :create, :update, :destroy]
      
      resources :sessions, :only => [:create, :destroy]

      resources :questions, only: [:index, :show, :destroy, :create] do
      	resources :comments, :except => [:update, :destroy, :new, :edit]
      end

      resources :comments, :only => [:update, :destroy]
    end
  end
end