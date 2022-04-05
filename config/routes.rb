Rails.application.routes.draw do

root to: "public/homes#top"
# ユーザー用
# URL /customers/sign_in ...
devise_for :end_users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

devise_scope :end_user do
    post 'end_user/guest_sign_in', to: 'user/sessions#guest_sign_in'
  end

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
 scope module: :public do
    resources :posts
    resource :end_users, only:[:show, :edit, :update] do
     collection do
        get "quit"
        patch "out"
        end
      end
  end


end