Rails.application.routes.draw do
  get 'covers/home'
  get 'covers/new_cover'
  get 'covers/not_found'
  get 'covers/add_manually'
  get 'covers/load_cover'
  get 'covers/cover_upload'
  get 'covers/mark_not_found'
  get 'reports/index'
  match'reports/show_calendar', to: 'reports#show_calendar', via: [:get, :post]
  match'reports/show_report_form', to: 'reports#show_report_form', via: [:get, :post] 
  match'reports/save_report', to: 'reports#save_report', via: [:get, :post]
  resources :stats
  root 'main#index'
  get 'trailers/index'
  get 'trailers/not_found'
  match 'trailers/get_trailer', to: 'trailers#get_trailer', via: [:get, :post]
  match 'trailers/find', to: 'trailers#find', via: [:get, :post]
  match 'trailers/verify', to: 'trailers#verify', via: [:get, :post]
  match 'trailers/remove_current_trailer', to: 'trailers#remove_current_trailer', via: [:get, :post]
  match 'trailers/mark_not_found', to: 'trailers#mark_not_found', via: [:get, :post]
  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]
end
