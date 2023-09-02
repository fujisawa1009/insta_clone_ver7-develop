class Mypage::AccountsController < Mypage::BaseController
  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(profile_params)
      redirect_to edit_mypage_account_path, success: 'プロフィールを更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def profile_params
    params.require(:user).permit(:avatar, :email, :username)
  end
end
