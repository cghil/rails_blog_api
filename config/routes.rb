require 'api_constraints'

MarketPlaceApi::Application.routes.draw do
devise_for :users
  # Api definition
  namespace :api do
    namespace :v1 do
      # We are going to list our resources here
      resources :users, :only => [:show, :create, :update, :destroy]
      
      resources :sessions, :only => [:create, :destroy]


      patch '/questions/:id/upvote', to: 'questions#upvote'
      patch '/questions/:id/downvote', to: 'questions#downvote'

      # patch '/users/:id/add_bio', to: 'users#add_bio'

      resources :questions, only: [:index, :show, :destroy, :create] do
      	resources :comments, :except => [:update, :destroy, :new, :edit]
        resources :answers, :except => [:update, :destroy, :new, :edit]
      end

      resources :answers, :only => [:update, :destroy]
      resources :comments, :only => [:update, :destroy]
    end
  end
end