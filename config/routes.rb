# frozen_string_literal: true

Rails.application.routes.draw do
  root to: redirect('newsfeed')

  resources :comments, only: :index do
    post '/comments', to: 'comments#create'
    post '/reacted/', to: 'reacts#create', as: 'react'
  end

  get '/newsfeed', to: 'posts#newsfeed'

  resources :posts do
    resources :comments
    post '/reacted/', to: 'reacts#create', as: 'react'
  end

  devise_for :users, controllers: { registrations: 'users/registrations' }

  post 'user/:user_id/follow',to: 'users#create_follow', as: 'follow_user'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '*unknown_path', to: 'application#page_not_found', code: 404
end
