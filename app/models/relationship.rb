class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  validates :follower_id, uniqueness: { scope: :followed_id }

  # フォローが作成されたときに通知を作成するメソッド
  after_create :create_notification

  private

  def create_notification
    Notification.create(
      visitor_id: follower_id,
      visited_id: followed_id,
      follow_id: id,
      action: "follow"
    )
  end
end
