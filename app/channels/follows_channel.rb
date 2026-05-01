class FollowsChannel < ApplicationCable::Channel
  # クライアントがチャンネルを購読した時に呼ばれる
  # user_idごとに独立したストリームを作成する
  def subscribed
    user = User.find_by(id: params[:user_id])
    if user
      stream_for user
    else
      reject
    end
  end

  def unsubscribed
  end
end
