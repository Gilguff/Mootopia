class ProfilesController < ApplicationController
  before_action :set_user

  def show
    @profile = @user.profile || @user.build_profile
  end

  def edit
    @profile = @user.profile || @user.build_profile
  end

  def update
    @profile = @user.profile || @user.build_profile
    if @profile.update(profile_params)
      redirect_to user_profile_path(@user)
    else
      render :edit
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
