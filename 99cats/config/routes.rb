Rails.application.routes.draw do
  resources :cats, only: [:index, :show, :new, :create, :edit, :update]
  resources :cat_rental_requests, only: [:new, :create]
  post '/approve/:id', :to => 'cat_rental_requests#approve',
    as: 'approve_request_url'
  post '/deny/:id', :to => 'cat_rental_requests#deny',
    as: 'deny_request_url'

  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create]
  delete '/session/end', to: 'sessions#destroy', as: 'session_end_url'
end
