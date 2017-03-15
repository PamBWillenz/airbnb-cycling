Rails.application.routes.draw do
  
  devise_for :members

  resources :members do
    resources :profiles
  end
  
  resources :profiles, only: :index

  root 'home#index'

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
  end
  
end
