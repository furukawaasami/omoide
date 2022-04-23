class Admin::PostCommentsController < ApplicationController
  before_action :authenticate_admin!,except: [:top]
  def index
      @post_comments = PostComment.order(created_at: :desc).page(params[:page]).per(10)
      @posts = Post.all
      # @post = Post.find(params[:id])
  end

  def destroy
      PostComment.find(params[:id]).destroy
      redirect_to request.referer
  end
end
