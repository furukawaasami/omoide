Rails.application.routes.draw do

  root to: "public/homes#top"

  devise_for :end_users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  devise_scope :end_user do
    post 'end_user/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }

  scope module: :public do
    resources :posts do
      resources :post_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
    resources :end_users, only: [:index, :show] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
      member do
        get :favorite_lists
      end
      get '/end_users/:id/unsubscribe' => 'end_users#unsubscribe', as: 'unsubscribe'
      patch '/end_users/:id/withdrawal' => 'end_users#withdrawal', as: 'withdrawal'
    end
  end

  namespace :admin do
    resources :end_users, only: [:index, :show, :update, :destroy]
    resources :posts, only: [ :index,:show, :destroy] do
      resources :post_comments, only: [:index, :destroy]
    end
  end



end