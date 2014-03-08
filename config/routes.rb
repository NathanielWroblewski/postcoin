Postcoin::Application.routes.draw do
  root 'users#new'

  devise_for :users
  resources :users

  get '/amounts', to: 'pages#amount', as: :amount_page
end
