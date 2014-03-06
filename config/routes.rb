Postcoin::Application.routes.draw do
  devise_for :users
  root 'users#new'

  resources :users
end
