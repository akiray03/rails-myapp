Rails.application.routes.draw do
  get    '/login',   to: 'sessions#new', as: :login
  post   '/login',   to: 'sessions#create'
  get    '/logout',  to: 'sessions#destroy', as: :logout
  delete '/logout',  to: 'sessions#destroy'
  resources :feedbacks
  resources :users
  root 'feedbacks#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
