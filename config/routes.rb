Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
  resources :words, only: [:index, :new, :show, :create] do
    collection do
      get 'search', as: :search
    end
  end

  post 'search', to: "home#search", as: :search_for_words

  resources :translations, only: [:index, :new, :create, :show]

  root to: "home#index"
end
