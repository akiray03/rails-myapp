Rails.application.routes.draw do
  namespace :admin do
    resources :feedbacks
  end
  get    '/login',   to: 'sessions#new', as: :login
  post   '/login',   to: 'sessions#create', as: :login_process
  get    '/logout',  to: 'sessions#destroy', as: :logout
  delete '/logout',  to: 'sessions#destroy'
  resources :feedbacks do
    #resources :comments, to: :feedback_comments, only: %i(create)
    post 'comments', to: 'feedback_comments#create'
  end
  resources :users
  root 'feedbacks#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
