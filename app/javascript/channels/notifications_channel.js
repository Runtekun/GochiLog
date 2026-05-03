import consumer from "./consumer"

// ページ遷移のたびに購読をリセットして再購読する
let subscription = null

document.addEventListener("turbo:load", () => {
  if (subscription) {
    subscription.unsubscribe()
    subscription = null
  }

  const badgeEl = document.getElementById("notification-badge")
  if (!badgeEl) return

  subscription = consumer.subscriptions.create("NotificationsChannel", {
    // サーバーから通知を受信したときにバッジを表示する
    received(data) {
      const badge = document.getElementById("notification-badge")
      if (badge && data.unread_count > 0) {
        badge.classList.remove("hidden")
      }
    }
  })
})
