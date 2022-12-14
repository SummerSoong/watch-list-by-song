Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # root to: 'pages#home'
  devise_scope :user do
    authenticated :user do
      root 'lists#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
  resources :lists, only: %i[index show new create destroy] do
    resources :bookmarks, only: %i[new create] do
      resources :movies, only: [:create]
    end
  end

  resources :bookmarks, only: [:destroy]

  # get 'my_lists', to 'pages#my_lists', as: :my_lists
end
