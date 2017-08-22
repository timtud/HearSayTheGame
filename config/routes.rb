Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pages#home'

  resources :users, only: [:show]

  resources :followers, only: [:create, :destroy]

  resources :rounds, only: [:show, :update]

  resources :round_questions, only: [:create, :update] do
    resources :rounds, only: [:create]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
