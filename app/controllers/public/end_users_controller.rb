class Public::EndUsersController < ApplicationController
  def show
    @end_user = EndUser.find(params[:id])
    @posts = @end_user.posts
  end
  def index
    @end_users = EndUser.all
  end
end
