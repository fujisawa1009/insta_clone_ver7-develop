class Posts::CommentsController < ApplicationController
  before_action :require_login

  def show
    @comment = current_user.comments.find(params[:id])
  end

  def edit
    @comment = current_user.comments.find(params[:id])
  end

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.save
  end

  def update
    @comment = current_user.comments.find(params[:id])
    @comment.update(comment_params)
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy!
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(post_id: params[:post_id])
  end
end
