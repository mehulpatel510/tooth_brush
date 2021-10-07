Rails.application.routes.draw do

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get "/users/manage" => "users#manage"

  get "/" => "home#index", as: :home

  get "/schedules/summary" => "schedules:summary"

  resources :schedules
  resources :users
  resources :taskdetails

  get "/signin" => "sessions#new", as: :new_sessions
  post "/signin" => "sessions#create", as: :sessions
  delete "/signout" => "sessions#destroy", as: :destroy_session
end
