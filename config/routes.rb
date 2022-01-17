Rails.application.routes.draw do
  devise_for :users
  resources :books
  resources :users, only: :index
  root to: "books#index"
  mount LetterOpenerWeb::Engine, at: "/letter_opener_web" if Rails.env.development?
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
