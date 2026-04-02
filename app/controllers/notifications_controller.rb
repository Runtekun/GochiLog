class NotificationsController < ApplicationController
  before_action :authenticate_user!

  # 通知一覧を表示するアクション
  def index
    @notifications = current_user.passive_notifications.includes(:visitor).order(created_at: :desc)
    @notifications.where(checked: false).update_all(checked: true)
  end

  # すべての通知を既読にするアクション
  def read_all
    current_user.passive_notifications.where(checked: false).update_all(checked: true)
    redirect_to notifications_path
  end
end
