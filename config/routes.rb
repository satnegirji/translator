Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
  resources :words, only: [:index, :new, :show, :create] do
    collection do
      get 'search', as: :search
    end
  end

  resources :discussions do
    member do
      post 'create', to: "discussions#reply", as: :reply
      get 'edit/:reply_id', to: "discussions#edit_reply", as: :edit_reply
      patch 'update/:reply_id', to: "discussions#update_reply", as: :update_reply
    end
  end

  resources :users, only: [ :index, :show ]

  get '/dashboard', to: "dashboard#index", as: :dashboard
  post 'search', to: "dashboard#search", as: :search_for_words

  resources :translations, only: [:index, :new, :create, :show]

  root to: "home#index"
end
