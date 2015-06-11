Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  root to: 'pages#front'
  get '/home', to: 'videos#index'
  get '/genre/:name', to: 'categories#show', as: 'category'

  get '/register', to: 'users#new'
  post '/register', to: 'users#create'
  get '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#create'
  get '/sign_out', to: 'sessions#destroy'

  resources :videos, only: [:show] do
    collection do
      get '/search', to: 'videos#search'
    end
  end
end
