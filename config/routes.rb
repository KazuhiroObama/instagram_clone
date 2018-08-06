Rails.application.routes.draw do
  root to: 'sessions#new'
  resources :users, except: :index
  get '/picture/favorites/:id', to: 'pictures#favorite', as: 'picture_favorites'

  resources :sessions, only: [:new, :create, :destroy]
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  resources :favorites, only: [:create, :destroy]
  resources :icons

  resources :pictures, except: :edit do
    resources :comments, only: [:create, :update, :destroy]
  end

end
