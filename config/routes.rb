Rails.application.routes.draw do
  
  devise_for :members, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }

  resources :members do
    get :payout_account, on: :member
    resources :profiles
  end

  resources :profiles, only: :index

  root 'home#index'

  get 'host_locations', to: 'locations#host_locations'
  get 'payout_account', to: 'members#payout_account'

  resources :locations do 
    member do 
      get :add_images
      get :calendar
      get :add_available_dates
      get :remove_images
    end
  end

  resources :reservations, only: [:new, :create, :index] do 
    get :confirmation, on: :member
    get :cancel, on: :member
  end

  mount StripeEvent::Engine, at: '/stripe-web-hooks'
  
end
