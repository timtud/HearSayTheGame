Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pages#home'

  resources :users, only: [:show]

  resources :followers, only: [:create, :destroy]

  resources :rounds, only: [:show, :update, :create] do
    member do
      get "check_answer", to: "rounds#check_answer"
    end
    resources :round_questions, only: [:show, :create, :update]
  end

  Rails.application.routes.draw do
    get 'pages/leaderboard'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
