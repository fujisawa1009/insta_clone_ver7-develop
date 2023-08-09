class UserSessionsController < ApplicationController
  def new; end

  def create
    user = login(params[:email], params[:password])

    if user
      redirect_back_or_to '/', success: 'ログインしました'
    else
      flash.now[:danger] = t('flash.login_failure')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to login_path, success: 'ログアウトしました', status: :see_other
  end
end
