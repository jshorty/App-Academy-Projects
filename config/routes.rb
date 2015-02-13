Rails.application.routes.draw do
  resources :users
  resource :session, only: [:new, :create, :destroy]
  resources :subs
  resources :posts, except: [:destroy, :index] do
    resources :comments, only: :new
  end
  resources :post_subs, only: [:create, :destroy]
  resources :comments, only: :create
end
