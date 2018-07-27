Rails.application.routes.draw do
  root to: 'sessions#new'
  resources :pictures
  resources :comments
  get '/picture/favorites/:id', to: 'pictures#favorite', as: 'picture_favorites'
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  resources :favorites, only: [:create, :destroy]
  resources :icons
end
