import consumer from "./consumer"

let subscriptions = []

// ページ遷移のたびに購読をリセットして再購読する
document.addEventListener("turbo:load", () => {
  subscriptions.forEach(sub => sub.unsubscribe())
  subscriptions = []

  document.querySelectorAll("[data-review-id]").forEach((el) => {
    const reviewId = el.dataset.reviewId

    const sub = consumer.subscriptions.create(
      { channel: "LikesChannel", review_id: reviewId },
      {
        // サーバーからブロードキャストを受信したときにいいね数を更新する
        received(data) {
          const countEl = document.querySelector(`[data-likes-count="${data.review_id}"]`)
          if (countEl) countEl.textContent = data.likes_count
        }
      }
    )
    subscriptions.push(sub)
  })
})
