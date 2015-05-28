Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  get '/home', to: 'videos#index'
  get '/home/:id', to: 'videos#show', as: 'video'
  get '/genre/:name', to: 'categories#show', as: 'category'
end
