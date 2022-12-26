# frozen_string_literal: true

Rails.application.routes.draw do
  root 'users#index'

  resources :users
  resources :sessions, only: %i[new create destroy]
  resources :questions, except: %i[show new index]
  resources :hashtags, only: [:show], param: :text

  get '/users/:id/questions' => 'users#questions', as: :user_questions
  get 'specialists' => 'users#specialists'
  get 'sign_up' => 'users#new'
  get 'log_out' => 'sessions#destroy'
  get 'log_in' => 'sessions#new'
  get 'destroy' => 'users#destroy'
end
