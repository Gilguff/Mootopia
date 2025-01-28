class UsersController < ApplicationController
  before_action :set_user, only: %i[ show follow unfollow ]

  def index
    @users = User.all
  end

  def show
    @followers = @user.followers
    @following = @user.following
  end

  def follow
    if current_user.following << @user
      redirect_to user_profile_path(@user)
    else
      redirect_to user_profile_path(@user)
    end
  end

  def unfollow
    if current_user.following.delete(@user)
      redirect_to user_profile_path(@user)
    else
      redirect_to user_profile_path(@user)
    end
  end



  private
    def set_user
      @user = User.find(params[:id])
    end
end
