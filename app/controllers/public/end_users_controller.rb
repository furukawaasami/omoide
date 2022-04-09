class Public::EndUsersController < ApplicationController
  def show
    @end_user = current_end_user
    @posts = current_end_user.posts
  end
  def index
    @end_users = EndUser.all
  end
  def edit
  end
  def quit
  end
  def out
  end
  def update
  end
end
