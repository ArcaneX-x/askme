Rails.application.routes.draw do
  root 'users#index'

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :questions, except: [:show, :new, :index]


  get '/users/:id/questions' => 'users#questions', as: :user_questions
  get 'specialists' => 'users#specialists'
  get 'sign_up' => 'users#new'
  get 'log_out' => 'sessions#destroy'
  get 'log_in' => 'sessions#new'
  get 'destroy' => 'users#destroy'
end

