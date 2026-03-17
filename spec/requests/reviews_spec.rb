require 'rails_helper'

RSpec.describe "Reviews", type: :request do
  let(:user) { create(:user) }
  let(:shop) { create(:shop) }
  let(:review) { create(:review, user: user, shop: shop) }

  describe "GET /reviews" do
    context "未ログイン" do
      it "ログインページにリダイレクトされる" do
        get reviews_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "ログイン済み" do
      before { sign_in user }

      it "一覧が表示される" do
        get reviews_path
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "GET /reviews/:id" do
    context "未ログイン" do
      it "ログインページにリダイレクトされる" do
        get review_path(review)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "ログイン済み" do
      before { sign_in user }

      it "詳細が表示される" do
        get review_path(review)
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "GET /reviews/new" do
    context "未ログイン" do
      it "ログインページにリダイレクトされる" do
        get new_review_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "ログイン済み" do
      before { sign_in user }

      it "新規作成フォームが表示される" do
        get new_review_path
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "GET /reviews/:id/edit" do
    context "未ログイン" do
      it "ログインページにリダイレクトされる" do
        get edit_review_path(review)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "ログイン済み" do
      before { sign_in user }

      it "編集フォームが表示される" do
        get edit_review_path(review)
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "DELETE /reviews/:id" do
    context "未ログイン" do
      it "ログインページにリダイレクトされる" do
        delete review_path(review)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "ログイン済み" do
      before { sign_in user }

      it "レビューを削除してレビュー一覧にリダイレクトされる" do
        review
        expect { delete review_path(review) }.to change(Review, :count).by(-1)
        expect(response).to redirect_to(reviews_path)
      end
    end
  end
end
