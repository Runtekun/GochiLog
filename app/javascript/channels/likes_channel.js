import consumer from "./consumer"

// レビュー詳細ページのいいねボタンをリアルタイム更新する
document.querySelectorAll("[data-review-id]").forEach((el) => {
  const reviewId = el.dataset.reviewId

  consumer.subscriptions.create(
    { channel: "LikesChannel", review_id: reviewId },
    {
      // サーバーからブロードキャストを受信したときにいいね数を更新する
      received(data) {
        const countEl = document.querySelector(`[data-likes-count="${data.review_id}"]`)
        if (countEl) {
          countEl.textContent = data.likes_count
        }
      }
    }
  )
})
