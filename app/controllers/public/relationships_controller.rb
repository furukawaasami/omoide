class Public::RelationshipsController < ApplicationController
  before_action :authenticate_end_user!,except: [:top]
  # フォローするとき
  def create
    current_end_user.follow(params[:end_user_id])
    redirect_to request.referer
  end
  # フォロー外すとき
  def destroy
    current_end_user.unfollow(params[:end_user_id])
    redirect_to request.referer
  end
  # フォロー一覧
  def followings
    @end_user = EndUser.find(params[:end_user_id])
    @end_users = EndUser.where(id: Relationship.where(follower_id: params[:end_user_id]).pluck(:followed_id), is_deleted: false)
  end
  # フォロワー一覧
  def followers
    @end_user = EndUser.find(params[:end_user_id])
    @end_users = EndUser.where(id: Relationship.where(followed_id: params[:end_user_id]).pluck(:follower_id), is_deleted: false)
  end
end
