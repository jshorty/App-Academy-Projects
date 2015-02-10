Rails.application.routes.draw do
  resources :cats, only: [:index, :show, :new, :create, :edit, :update]
  resources :cat_rental_requests, only: [:new, :create]
  patch '/approve/:id', :to => 'cat_rental_requests#approve',
    as: 'approve_request_url'
  patch '/deny/:id', :to => 'cat_rental_requests#deny',
    as: 'deny_request_url'
end
