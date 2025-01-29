class UsersController < ApplicationController
  before_action :set_user, only: %i[ show follow unfollow ]

  def index
    @users = User.all.order("username ASC")
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

  def search
    if params[:username_search].present?
      @users = User.where("username ILIKE ?", "%#{params[:username_search]}%").order("username ASC")
    else
      @users = User.all.order("username ASC")
    end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update("search_results", partial: "users/search_results", locals: { users: @users })
      end
    end
  end



  private
    def set_user
      @user = User.find(params[:id])
    end
end
