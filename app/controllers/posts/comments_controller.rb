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
    return unless @comment.save

    create_notifications_about_comment_to_own_post(@comment)
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

  def create_notifications_about_comment_to_own_post(comment)
    notification = Notification.create!(title: 'あなたの投稿にコメントがありました', url: post_url(comment.post))
    notification.notify(comment.post.user)
  end
end
