class ProfilesController < ApplicationController
  before_action :set_user

  def show
    @profile = @user.profile || @user.build_profile
    @posts = @user.posts
  end

  def edit
    @profile = @user.profile || @user.build_profile
  end

  def update
    @profile = @user.profile || @user.build_profile
    if @profile.update(profile_params)
      redirect_to user_profile_path(@user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def profile_params
    params.expect(profile: [ :bio ])
  end
end
