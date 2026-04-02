class AddDefaultCheckedToNotifications < ActiveRecord::Migration[7.2]
  def change
    change_column_default :notifications, :checked, from: nil, to: false
    Notification.where(checked: nil).update_all(checked: false)
  end
end
