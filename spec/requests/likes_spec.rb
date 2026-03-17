require 'rails_helper'

RSpec.describe "Likes", type: :request do
  let(:user) { create(:user) }
  let(:review) { create(:review) }

  describe "POST /reviews/:review_id/like" do
    context "未ログイン" do
      it "ログインページにリダイレクトされる" do
        post review_like_path(review)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "ログイン済み" do
      before { sign_in user }

      it "いいねが作成される" do
        expect {
          post review_like_path(review)
        }.to change(Like, :count).by(1)
      end
    end
  end

  describe "DELETE /reviews/:review_id/like" do
    context "未ログイン" do
      it "認証エラーになる" do
        delete review_like_path(review)
        expect(response).to have_http_status(:unauthorized).or redirect_to(new_user_session_path)
      end
    end

    context "ログイン済み" do
      before { sign_in user }

      it "いいねが削除される" do
        create(:like, user: user, review: review)
        expect {
          delete review_like_path(review)
        }.to change(Like, :count).by(-1)
      end
    end
  end
end
