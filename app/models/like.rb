class Like < ApplicationRecord
  belongs_to :user
  belongs_to :review
  validates :user_id, uniqueness: { scope: :review_id }

  # いいねが作成されたときに通知を作成するメソッド
  after_create :create_notification

  private

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
