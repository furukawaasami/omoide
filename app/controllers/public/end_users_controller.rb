class Public::EndUsersController < ApplicationController
  def show
    @end_user = EndUser.find(params[:id])
    @posts = @end_user.posts
  end
  def index
    @end_users = EndUser.where(is_deleted: false)
  end
  def favorite_lists
    @end_user = EndUser.find(params[:id])
    favorites= Favorite.where(end_user_id: @end_user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end
  def withdrawal
    @end_user = EndUser.find(params[:id])
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @end_user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end
end
