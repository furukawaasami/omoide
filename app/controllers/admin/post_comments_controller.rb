class Admin::PostCommentsController < ApplicationController
  def index
    @post_comments = PostComment.all
    @posts = Post.all
    # @post = Post.find(params[:id])
  end

  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to request.referer
  end
end
