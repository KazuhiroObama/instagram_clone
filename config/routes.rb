Rails.application.routes.draw do
  root 'users#show'
  resources :users, except: :index
  resources :pictures, except: :edit do
    collection do
      get :favorites
    end
    resources :comments, only: [:create, :update, :destroy]
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :favorites, only: [:create, :destroy]
  resources :icons

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
