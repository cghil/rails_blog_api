require 'api_constraints'

MarketPlaceApi::Application.routes.draw do
devise_for :users
  # Api definition
  namespace :api do
    namespace :v1 do
      # We are going to list our resources here
      resources :users, :only => [:show, :create, :update, :destroy]
      resources :sessions, :only => [:create, :destroy]
      resources :questions, :only => [:index, :show, :update, :destroy, :create]
    end
  end
end
