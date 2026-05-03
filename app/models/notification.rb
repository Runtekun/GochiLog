class Notification < ApplicationRecord
  belongs_to :visitor, class_name: "User"
  belongs_to :visited, class_name: "User"
  belongs_to :review, optional: true
  belongs_to :comment, optional: true
  belongs_to :follow, class_name: "Relationship", optional: true

  # 通知作成後に受信者へリアルタイム通知をブロードキャストする
  after_create_commit :broadcast_notification

  private

  def broadcast_notification
    unread_count = visited.passive_notifications.where(checked: false).count
    NotificationsChannel.broadcast_to(visited, { unread_count: unread_count })
  end
end
