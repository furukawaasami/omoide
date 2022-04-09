class Public::PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.end_user_id = current_end_user.id
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit

  end

  private
    def post_params
      params.require(:post).permit(:title, :explanation, :image, :latitude, :longitude, :address)
    end
end
