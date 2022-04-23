class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!,except: [:top]
  def index
      @posts = Post.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
      @post = Post.find(params[:id])
  end

  def destroy
      @post = Post.find(params[:id])
      @post.destroy
      redirect_to admin_end_user_path(@post.end_user.id)
  end
end
