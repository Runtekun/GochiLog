require 'rails_helper'

RSpec.describe "Follows", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  describe "POST /users/:user_id/follow" do
    context "未ログイン" do
      it "ログインページにリダイレクトされる" do
        post user_follow_path(other_user)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "ログイン済み" do
      before { sign_in user }

      it "フォロー関係が作成される" do
        expect {
          post user_follow_path(other_user)
        }.to change(Relationship, :count).by(1)
      end
    end
  end

  describe "DELETE /users/:user_id/follow" do
    context "未ログイン" do
      it "認証エラーになる" do
        delete user_follow_path(other_user)
        expect(response).to have_http_status(:unauthorized).or redirect_to(new_user_session_path)
      end
    end

    context "ログイン済み" do
      before { sign_in user }

      it "フォロー関係が削除される" do
        user.follow(other_user)
        expect {
          delete user_follow_path(other_user)
        }.to change(Relationship, :count).by(-1)
      end
    end
  end
end
