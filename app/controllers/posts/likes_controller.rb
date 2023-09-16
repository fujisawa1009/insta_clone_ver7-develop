class Posts::LikesController < ApplicationController
  before_action :require_login

  def create
    @post = Post.find(params[:post_id])
    current_user.like(@post)
    create_notifications_about_like(@post)
  end

  def destroy
    @post = Post.find(params[:post_id])
    current_user.unlike(@post)
  end

  private

  def create_notifications_about_like(post)
    notification = Notification.create!(title: "#{current_user.username}さんがあなたの投稿をいいねしました", url: post_url(post))
    notification.notify(post.user)
  end
end
