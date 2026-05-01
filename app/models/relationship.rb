class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  validates :follower_id, uniqueness: { scope: :followed_id }

  # フォローが作成・削除されたときに通知作成とリアルタイム更新を行う
  after_create_commit :create_notification
  after_destroy_commit :broadcast_follow_count

  private

  # フォロワー数・フォロー中数をリアルタイムでブロードキャストする
  def broadcast_follow_count
    FollowsChannel.broadcast_to(followed, {
      user_id: followed_id,
      followers_count: followed.followers.count,
      following_count: followed.following.count
    })
    FollowsChannel.broadcast_to(follower, {
      user_id: follower_id,
      followers_count: follower.followers.count,
      following_count: follower.following.count
    })
  end

  # フォローの通知を作成するメソッド
  def create_notification
    Notification.create(
      visitor_id: follower_id,
      visited_id: followed_id,
      follow_id: id,
      action: "follow"
    )
  end
end
