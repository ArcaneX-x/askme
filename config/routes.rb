# frozen_string_literal: true

Rails.application.routes.draw do
  root "users#index"

  resources :users
  resource :session, only: %i[new create destroy]
  resources :questions, except: %i[show new index]
  resources :hashtags, only: [:show], param: :text

  get "/users/:id/questions" => "users#questions", as: :user_questions
  get "specialists" => "users#specialists"
end
