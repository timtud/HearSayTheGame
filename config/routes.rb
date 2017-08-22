Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :users, only: [:show]

  resources :followers, only: [:create, :destroy]

  resources :rounds, only: [:show, :update, :create] do
    resources :round_questions, only: [:show, :create, :update]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
