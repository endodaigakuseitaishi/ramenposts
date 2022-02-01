Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'posts#index'



  resource :timeline, only: [:show]

  resources :posts do
    collection do
      get 'search'
    end
    resources :comments, only: [:create, :new]
    resource :like, only: [:show, :create, :destroy]
  end

  resources :accounts, only: [:show] do
    resources :follows, only: [:create]
    resources :unfollows, only: [:create]
    # :followsの中にdestroyアクションを入れるか迷った結果
  end

  resource :profile, only: [:show, :edit, :update]
  resources :favorites, only: [:index]
  resources :ranks, only: [:index]
  end
