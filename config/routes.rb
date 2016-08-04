Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "password_resets/create"
  get "password_resets/edit"
  get "password_resets/update"
  root "landing#index"

  resources :registrations, only: [:create]
  post "telegram" => "telegram#index"
  get "signup" => "registrations#new", as: "signup"

  get "settings" => "settings#index"

  get "settings/email" => "settings#email", as: "settings_email"
  patch "settings/email" => "settings#update_email", as: "settings_email_update"

  get "settings/telegram" => "settings#telegram", as: "settings_telegram"
  patch "settings/telegram" => "settings#update_telegram", as: "settings_telegram_update"

  get "settings/password" => "settings#password", as: "settings_password"
  patch "settings/password" => "settings#update_password", as: "settings_password_update"

  resources :sessions, only: [:create]
  get "login" => "sessions#new", as: "login"
  get "logout" => "sessions#destroy", as: "logout"

  resources :cards, except: :show
  resources :reviews, only: [:new, :create]
  resources :password_resets
  resources :helps, only: [:index]
end
