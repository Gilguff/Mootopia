class PostsController < ApplicationController
  # update index when added follwers
  def index
    @posts = Post.all
      .includes(:likings)
      .order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user

    if @post.save
      redirect_to
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def post_params
      params.expect(post: [ :body ])
    end
end
