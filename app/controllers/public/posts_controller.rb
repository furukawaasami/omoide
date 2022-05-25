class Public::PostsController < ApplicationController
  before_action :authenticate_end_user!,except: [:top]
  before_action :valid_user!,only: [:show]
  def index
      @posts = Post.joins(:end_user).where(end_user: {is_deleted: false})
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
      flash[:notice] = "登録が完了しました。"
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit
      @post = Post.find(params[:id])
    if @post.end_user == current_end_user
      render 'edit'
    else
      redirect_to posts_path
    end
  end

  def update
        @post = Post.find(params[:id])
    if  @post.update(post_params)
        flash[:notice] = "登録が完了しました。"
        redirect_to end_user_path(current_end_user.id)
    else
        render 'edit'
    end
  end

  def destroy
      @post = Post.find(params[:id])
      if @post.end_user == current_end_user
      @post.destroy
      flash[:notice] = "投稿を削除しました。"
      redirect_to end_user_path(current_end_user.id)
      else
      render 'index'
      end
  end

  private

    def valid_user!
      @post = Post.find(params[:id])
      if @post.end_user.is_deleted == true
        redirect_to posts_path
      end
    end

    def post_params
      params.require(:post).permit(:title, :explanation, :image, :latitude, :longitude, :address, :image)
    end
end
