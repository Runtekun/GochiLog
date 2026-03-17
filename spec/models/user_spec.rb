require 'rails_helper'

RSpec.describe User, type: :model do
  describe "バリデーション" do
    it "有効なユーザーは保存できる" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "名前がない場合は無効" do
      user = build(:user, name: nil)
      expect(user).not_to be_valid
    end

    it "名前が31文字以上の場合は無効" do
      user = build(:user, name: "a" * 31)
      expect(user).not_to be_valid
    end

    it "名前が重複している場合は無効" do
      create(:user, name: "テストユーザー")
      user = build(:user, name: "テストユーザー")
      expect(user).not_to be_valid
    end

    it "メールアドレスがない場合は無効" do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
    end

    it "メールアドレスが重複している場合は無効" do
      create(:user, email: "test@example.com")
      user = build(:user, email: "test@example.com")
      expect(user).not_to be_valid
    end

    it "パスワードが5文字以下の場合は無効" do
      user = build(:user, password: "abc12", password_confirmation: "abc12")
      expect(user).not_to be_valid
    end

    it "自己紹介が501文字以上の場合は無効" do
      user = build(:user, bio: "a" * 501)
      expect(user).not_to be_valid
    end
  end

  describe "アソシエーション" do
    it "ユーザーを削除するとレビューも削除される" do
      user = create(:user)
      create(:review, user: user)
      expect { user.destroy }.to change(Review, :count).by(-1)
    end
  end

  describe "#following?" do
    it "フォローしているユーザーに対してtrueを返す" do
      user = create(:user)
      other = create(:user)
      user.follow(other)
      expect(user.following?(other)).to be true
    end

    it "フォローしていないユーザーに対してfalseを返す" do
      user = create(:user)
      other = create(:user)
      expect(user.following?(other)).to be false
    end
  end
end
