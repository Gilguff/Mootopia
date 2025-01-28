class FollowingsController < ApplicationController
  def create
    followed_user = User.find(params[:followed_id])
    current_user.following << followed_user
    redirect_to user_path(followed_user)
  end

  def destroy
    following = current_user.active_followings.find(params[:id])
    following.destroy
    redirect_to user_path(following.followed)
  end
end
