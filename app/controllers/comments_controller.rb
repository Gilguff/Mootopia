class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ edit update destroy ]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.author = current_user

    if @comment.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    redirect_to root_path
  end

  private
    def comment_params
      params.expect(comment: [ :body ])
    end

    def set_comment
      @comment = Comment.find(params[:id])
    end
end
