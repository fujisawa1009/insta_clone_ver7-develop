class Posts::LikesController < ApplicationController
  before_action :require_login

  def create
    @post = Post.find(params[:post_id])
    # rubocop:disable Style/GuardClause
    if current_user.like(@post)
      create_notifications_about_like(@post)
      # メール通知を許可している場合のみ通知する
      if @post.user.accepted_notification?(:on_liked)
        UserMailer.with(user_from: current_user, user_to: @post.user, post: @post).like_post.deliver_later
      end
    end
    # rubocop:enable Style/GuardClause
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
