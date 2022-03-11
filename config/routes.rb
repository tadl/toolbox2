Rails.application.routes.draw do
  get 'calendar/index'
  get 'calendar/workorders'
  get 'calendar/sign'
  resources :infractions
  resources :locations
  get 'covers/home'
  get 'covers/new_cover'
  get 'covers/not_found'
  get 'covers/add_manually'
  get 'covers/load_cover'
  get 'covers/cover_upload'
  get 'covers/mark_not_found'
  get 'reports/index'
  get 'calendar/featured'
  match'reports/show_calendar', to: 'reports#show_calendar', via: [:get, :post]
  match'reports/show_report_form', to: 'reports#show_report_form', via: [:get, :post] 
  match'reports/save_report', to: 'reports#save_report', via: [:get, :post]
  match'closures', to: 'closures#index', via: [:get, :post]
  match'closures/new', to: 'closures#new', via: [:get, :post]
  match'closures/edit', to: 'closures#edit', via: [:get, :post]
  match'closures/save', to: 'closures#save', via: [:get, :post]
  match'closures/delete', to: 'closures#delete', via: [:get, :post]
  match'closures/feed', to: 'closures#feed', via: [:get, :post]
  match'numbers', to: 'numbers#index', via: [:get, :post]
  match'numbers/new', to: 'numbers#new', via: [:get, :post]
  match'numbers/save', to: 'numbers#save', via: [:get, :post]
  match'numbers/edit', to: 'numbers#edit', via: [:get, :post]
  match'numbers/delete', to: 'numbers#delete', via: [:get, :post]
  match'numbers/update', to: 'numbers#update', via: [:get, :post]
  match'numbers/numbers_for', to: 'numbers#numbers_for', via: [:get, :post]
  match'numbers/update_people', to: 'numbers#update_people', via: [:get, :post]
  match'numbers/staff_portal_load', to: 'numbers#staff_portal_load', via: [:get, :post]
  match 'directory', to: 'numbers#directory', via: [:get, :post], :defaults => { :format => 'xml' }
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
