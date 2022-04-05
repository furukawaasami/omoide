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
  def edit
  end
end
