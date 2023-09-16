class Mypage::NotificationsController < Mypage::BaseController
  def index
    @pagy, @user_notifications = pagy(current_user.user_notifications.includes(:notification).order(created_at: :desc))
  end
end
