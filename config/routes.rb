Rails.application.routes.draw do
  devise_for :members

  resources :members do
    resources :profiles
  end
  
  resources :profiles, only: :index
  get 'reservations/new'

  root 'home#index'

  resources :locations do 
    member do 
      get :add_images
      get :calendar
      get :add_available_dates
    end
  end
  
end
