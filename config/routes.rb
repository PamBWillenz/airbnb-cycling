Rails.application.routes.draw do
  devise_for :members

  resources :members do
    resources :profiles
  end
  
  resources :profiles, only: :index

  root 'home#index'
  
end
