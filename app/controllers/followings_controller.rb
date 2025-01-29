class FollowingsController < ApplicationController
  before_action :set_user


  def create
    followed_user = User.find(params[:followed_id])
    current_user.following << followed_user
    respond_to do |format|
      format.html { redirect_to user_path(followed_user) }
      format.turbo_stream
    end
  end

  def destroy
    following = current_user.active_followings.find_by(followed_id: params[:followed_id])
    following.destroy
    respond_to do |format|
      format.html { redirect_to user_path(User.find(params[:followed_id])) }
      format.turbo_stream
    end
  end

  private
    def set_user
      @user = User.find_by(id: params[:followed_id])
    end
end
