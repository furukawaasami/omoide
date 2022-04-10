Rails.application.routes.draw do

root to: "public/homes#top"

devise_for :end_users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

devise_scope :end_user do
    post 'end_user/guest_sign_in', to: 'user/sessions#guest_sign_in'
  end

devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
 scope module: :public do
    resources :posts
    resources :end_users, only: [:index, :show] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    end
  end


end