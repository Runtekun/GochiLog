class LikesChannel < ApplicationCable::Channel
  # クライアントがチャンネルを購読した時に呼ばれる
  # review_idごとに独立したストリームを作成する
  def subscribed
    review = Review.find_by(id: params[:review_id])
    if review
      stream_for review
    else
      reject
    end
  end

  def unsubscribed
  end
end
