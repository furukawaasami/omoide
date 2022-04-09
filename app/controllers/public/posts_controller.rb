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
