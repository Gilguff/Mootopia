class UsersController < ApplicationController
  before_action :set_user

  def index
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
