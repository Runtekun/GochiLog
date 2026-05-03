class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    # ログインユーザー自身の通知ストリームを購読する
    stream_for current_user
  end

  def unsubscribed; end
end
