require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }

  describe "GET /users/:id" do
    context "未ログイン" do
      it "ログインページにリダイレクトされる" do
        get user_path(user)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "ログイン済み" do
      before { sign_in user }

      it "プロフィールが表示される" do
        get user_path(user)
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
