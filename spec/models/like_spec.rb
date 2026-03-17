require 'rails_helper'

RSpec.describe Like, type: :model do
  describe "バリデーション" do
    it "有効ないいねは保存できる" do
      like = build(:like)
      expect(like).to be_valid
    end

    it "同じユーザーが同じレビューに2回いいねできない" do
      user = create(:user)
      review = create(:review)
      create(:like, user: user, review: review)
      duplicate = build(:like, user: user, review: review)
      expect(duplicate).not_to be_valid
    end
  end
end
