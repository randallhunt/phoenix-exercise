Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :applications, path: '/applications'
  resources :clients, path: '/clients'
end
