Rails.application.routes.draw do
  get 'home/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "home#index"
  resources :user
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to:'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  resources :category  do
    resources :article
  end
end
