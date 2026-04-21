class Admin::SessionsController < ApplicationController
  layout "admin_login"

  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.valid_password?(params[:password]) && @user.admin?
      sign_in @user
      redirect_to admin_root_path, notice: "管理者としてログインしました。"
    else
      flash.now[:alert] = "メールアドレスまたはパスワードが正しくありません。"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    sign_out current_user
    redirect_to admin_login_path, notice: "ログアウトしました。"
  end
end
