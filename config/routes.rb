# frozen_string_literal: true

Rails.application.routes.draw do
  root to: redirect('newsfeed')

  resources :comments, only: %i[index destroy] do
    resources :comments, only: :create
  end

  get '/newsfeed', to: 'posts#newsfeed'

  resources :posts do
    resources :comments, only: :create
  end

  resources :reacts, only: :create

  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }

  resources :users do
    post '/follow', to: 'users#create_follow', as: 'follow'
    delete '/unfollow', to: 'users#destroy_follow', as: 'unfollow', defaults: { format: 'js' }
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '*unknown_path', to: 'application#page_not_found', code: 404
end
