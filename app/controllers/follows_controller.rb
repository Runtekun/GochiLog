class FollowsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def create
    current_user.follow(@user)
    broadcast_follow_counts
    respond_to do |format|
      format.turbo_stream # Turboリクエストの場合は create.turbo_stream.erb を使って画面の一部（フォロー）だけ更新する。
      format.html { redirect_to @user } # HTMLリクエストの場合、フォロー後にユーザープロフィールへ遷移する。
    end
  end

  def destroy
    current_user.unfollow(@user)
    respond_to do |format|
      format.turbo_stream # Turboリクエストの場合は destroy.turbo_stream.erb を使って画面の一部（フォロー解除）だけ更新する。
      format.html { redirect_to @user } # HTMLリクエストの場合、フォロー解除後にユーザープロフィールへ遷移する。
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  # フォロー作成時にフォロワー数・フォロー中数をリアルタイムでブロードキャストする
  def broadcast_follow_counts
    FollowsChannel.broadcast_to(@user, {
      user_id: @user.id,
      followers_count: @user.followers.count,
      following_count: @user.following.count
    })
    FollowsChannel.broadcast_to(current_user, {
      user_id: current_user.id,
      followers_count: current_user.followers.count,
      following_count: current_user.following.count
    })
  end
end
