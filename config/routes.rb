Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  root to: 'videos#index'
  get '/genre/:name', to: 'categories#show', as: 'category'

  resources :videos, only: [:show] do
    collection do
      get '/search', to: 'videos#search'
    end
  end
end
