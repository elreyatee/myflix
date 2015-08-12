Myflix::Application.routes.draw do

  get 'ui(/:action)', controller: 'ui'
  root to: 'pages#front'
  get 'home', to: 'videos#index'
  get 'genre/:name', to: 'categories#show', as: 'category'
  get 'register', to: 'users#new'
  post 'register', to: 'users#create'
  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create'
  get 'sign_out', to: 'sessions#destroy'

  resources :relationships, only: [:create, :destroy, :show]
  resources :users, only: [:show]
  
  resources :videos, only: [:show] do
    collection do
      get 'search', to: 'videos#search'
    end
    resources :reviews, only: [:create]
  end

  get 'my_queue', to: 'queue_items#index'
  resources :queue_items, only: [:create, :destroy]
  post 'update_queue', to: 'queue_items#update_queue'
end
