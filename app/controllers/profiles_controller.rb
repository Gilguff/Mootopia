class ProfilesController < ApplicationController
  before_action :set_user

  def show
    @profile = @user.profile || @user.create_profile
    @posts = @user.posts
  end

  def edit
    @profile = @user.profile || @user.create_profile
  end

  def update
    @profile = @user.profile
    if @profile.update(profile_params)
      redirect_to user_profile_path(@user), notice: "Profile updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def profile_params
    params.require(:profile).permit(:bio, :profile_picture)
  end
end
