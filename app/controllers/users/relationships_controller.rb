class Users::RelationshipsController < ApplicationController
  before_action :require_login

  def create
    @user = User.find(params[:user_id])
    current_user.follow(@user)
    create_notifications_about_follow(@user)
  end

  def destroy
    @user = User.find(params[:user_id])
    current_user.unfollow(@user)
  end

  private

  def create_notifications_about_follow(user)
    notification = Notification.create!(title: "#{current_user.username}さんにフォローされました", url: user_url(current_user))
    notification.notify(user)
  end
end
