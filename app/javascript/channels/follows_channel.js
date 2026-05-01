import consumer from "./consumer"

let subscriptions = []

// ページ遷移のたびに購読をリセットして再購読する
document.addEventListener("turbo:load", () => {
  subscriptions.forEach(sub => sub.unsubscribe())
  subscriptions = []

  document.querySelectorAll("[data-user-id]").forEach((el) => {
    const userId = el.dataset.userId

    const sub = consumer.subscriptions.create(
      { channel: "FollowsChannel", user_id: userId },
      {
        // サーバーからブロードキャストを受信したときにフォロー数を更新する
        received(data) {
          const followersEl = document.querySelector(`[data-followers-count="${data.user_id}"]`)
          const followingEl = document.querySelector(`[data-following-count="${data.user_id}"]`)
          if (followersEl) followersEl.textContent = data.followers_count
          if (followingEl) followingEl.textContent = data.following_count
        }
      }
    )
    subscriptions.push(sub)
  })
})
