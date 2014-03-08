Postcoin::Application.routes.draw do
  root 'users#new'

  devise_for :users
  resources :users
  resources :transactions, only: [:new, :create]

  get '/amounts', to: 'pages#amounts', as: :amount_page
end
