YACMS::Application.routes.draw do
  namespace :admin do
    resources :pages do
      collection do
        post :rebuild
        post :add_image
        post :add_file
        post :add_snippet
      end
    end
    resources :posts do
      collection do
        post :add_image
        post :add_file
        post :add_snippet
      end
    end
    resources :images, except: :show
    resources :attachments, except: :show
    resources :snippets
    resources :users, except: [:show, :new, :create]
    resources :settings, only: [:edit, :update]
  end

  resources :pages, only: [:show]
  resources :posts, only: [:index, :show] do
    resources :comments, only: [:new, :create]
  end

  devise_for :users

  root to: 'pages#home'
end
