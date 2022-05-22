class Public::FavoritesController < ApplicationController
  before_action :authenticate_end_user!,except: [:top]
  def create
      @post = Post.find(params[:post_id])
      unless @post.favorited_by?(current_end_user)
      @favorite = current_end_user.favorites.new(post_id: @post.id)
      @favorite.save
      end
  end

  def destroy
      @post = Post.find(params[:post_id])
      @favorite = current_end_user.favorites.find_by(post_id: @post.id)
      @favorite.destroy
  end
end
