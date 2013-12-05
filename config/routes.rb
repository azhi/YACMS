YACMS::Application.routes.draw do
  namespace :admin do
    resources :pages do
      collection do
        post :rebuild
      end
    end
    resources :posts
    resources :settings, only: [:edit, :update]
  end

  resources :pages, only: [:show]
  resources :posts, only: [:index, :show] do
    resources :comments, only: [:new, :create]
  end

  devise_for :users

  root to: 'pages#home'
end
