Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get '/food/search', to: 'food#search'

  resources :schedules, only: [:index, :show, :create] do
    resources :meals, only: [:create]
  end
end
