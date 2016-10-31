Rails.application.routes.draw do
  devise_for :members

  resources :members do
    resources :profiles
  end
  
  root 'home#index'
  
end
