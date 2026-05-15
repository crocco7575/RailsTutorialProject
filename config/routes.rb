Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token

  resources :products do
    resources :subscribers, only: [ :create ]
  end
  resource :unsubscribe, only: [ :show ]
  resource :sign_up, only: [ :show, :create ]

  root "products#index"

  namespace :settings do
    resource :password, only: [ :show, :update ]
    resource :profile, only: [ :show, :update ]
    resource :user, only: [ :show, :destroy ]
    resource :email, only: [ :show, :update ]

    root to: redirect("/settings/profile")
  end

  namespace :email do
    resources :confirmations, param: :token, only: [ :show ]
  end

  # Admins Only
  namespace :store do
    resources :products
    resources :users

    root to: redirect("/store/products")
  end
end
