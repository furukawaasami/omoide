class Public::PostsController < ApplicationController

  def index
  end

  def show
  end

  def new
    @post = Post.new
    @posts = Post.all
    @hash = Gmaps4rails.build_markers(@posts) do |post, marker|
    marker.lat post.latitude
    marker.lng post.longitude
    marker.infowindow post.address
    end
  end

  def create
    @post = Post.new(post_params)
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
