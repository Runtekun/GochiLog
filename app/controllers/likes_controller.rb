class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @review = Review.find(params[:review_id])
    @review.likes.create!(user: current_user)
    respond_to do |format|
      format.turbo_stream # Turboリクエストの場合は create.turbo_stream.erb を使って画面の一部（いいね）だけ更新する。
      format.html { redirect_back_or_to review_path(@review) } # HTMLリクエストの場合、いいねを押した後に元のページへ戻る（取得できない場合はレビュー詳細へ）
    end
  end

  def destroy
    @review = Review.find(params[:review_id])
    like = @review.likes.find_by!(user: current_user)
    like.destroy!
    respond_to do |format|
      format.turbo_stream # Turboリクエストの場合は destroy.turbo_stream.erb を使って画面の一部（いいね）だけ更新する。
      format.html { redirect_back_or_to review_path(@review) } # HTMLリクエストの場合、いいね解除後に元のページへ戻る（取得できない場合はレビュー詳細へ）
    end
  end
end
