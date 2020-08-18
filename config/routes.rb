Rails.application.routes.draw do
  root 'main#index'
  get 'trailers/index'
  match 'trailers/verify', to: 'trailers#verify', via: [:get, :post]
  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]
end
