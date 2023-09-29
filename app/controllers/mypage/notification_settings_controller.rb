class Mypage::NotificationSettingsController < Mypage::BaseController
  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(notification_settings_params)
      redirect_to edit_mypage_notification_setting_path, success: '設定を更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def notification_settings_params
    params.require(:user).permit(notification_timing_ids: [])
  end
end
