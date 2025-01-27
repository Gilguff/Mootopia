class PostsController < ApplicationController
  before_action :set_post, only: %i[ edit update destroy ]

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

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  private
    def post_params
      params.expect(post: [ :body ])
    end

    def set_post
      @post = Post.find(params[:id])
    end
end
