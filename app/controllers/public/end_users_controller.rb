class Public::EndUsersController < ApplicationController
  def show
    @end_user = EndUser.find(params[:id])
    @posts = @end_user.posts
  end
  def index
    @end_users = EndUser.all
  end
  def favorite_lists
    @end_user = EndUser.find(params[:id])
    favorites= Favorite.where(end_user_id: @end_user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end
end
