Rails.application.routes.draw do
  get "users/search", to: "search#index"
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'registrations' }
  root to: 'pages#home'



  devise_scope :user do
    get "/users/:id", to: "users#show", as: :user
  end

  mount Attachinary::Engine => "/attachinary"

  resources :followers, only: [:create, :destroy]

  resources :relationships, only: [:create, :destroy]

  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :rounds, only: [:show, :update, :create] do
    member do
      get "check_answer", to: "rounds#check_answer"
    end
    get "show_result", to: "rounds#show_result"
    resources :round_questions, only: [:show, :create, :update]
  end

  Rails.application.routes.draw do
    get 'leaderboard' => 'pages#leaderboard'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
