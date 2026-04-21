class Admin::BaseController < ApplicationController
  before_action :authenticate_admin!

  layout "admin/layouts/application"

  private

  # 管理者認証のメソッド
  def authenticate_admin!
    unless user_signed_in? && current_user.admin?
      redirect_to new_user_session_path, alert: "管理者権限が必要です。"
    end
  end
end
