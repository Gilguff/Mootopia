class LikingsController < ApplicationController
  before_action :set_post

  def create
    current_user.likings.create!(post: @post)
    respond_to do |format|
      format.html { redirect_to root_path }
      format.turbo_stream
    end
  end

  def destroy
    liking = current_user.likings.find(params[:id])
    liking.destroy
    respond_to do |format|
      format.html { redirect_to root_path }
      format.turbo_stream
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
