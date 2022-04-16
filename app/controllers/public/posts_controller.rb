class Public::PostsController < ApplicationController

  def index
    @posts = Post.all
    # @post = Post.find(params[:id])
  #   @hash = Gmaps4rails.build_markers(@places) do |posts, marker|
  #   marker.lat posts.latitude
  #   marker.lng posts.longitude
  # end
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
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
    @post = Post.find(params[:id])
  end
  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to end_user_path(current_end_user.id)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to request.referer
  end

  private

    def post_params
      params.require(:post).permit(:title, :explanation, :image, :latitude, :longitude, :address)
    end
end
