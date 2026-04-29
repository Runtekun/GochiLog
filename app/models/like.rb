class Like < ApplicationRecord
  belongs_to :user
  belongs_to :review
  validates :user_id, uniqueness: { scope: :review_id }

  # いいねが作成・削除されたときに通知作成とリアルタイム更新を行う
  after_create :create_notification
  after_create_commit :broadcast_like_count
  after_destroy_commit :broadcast_like_count

  private

  # いいね数をリアルタイムでブロードキャストする
  def broadcast_like_count
    LikesChannel.broadcast_to(review, {
      review_id: review_id,
      likes_count: review.likes.count
    })
  end

  def create_notification
    return if user == review.user
    Notification.create(
      visitor_id: user_id,
      visited_id: review.user_id,
      review_id: review_id,
      action: "like"
    )
  end
end
