require 'rails_helper'

RSpec.describe Review, type: :model do
  describe "バリデーション" do
    it "有効なレビューは保存できる" do
      review = build(:review)
      expect(review).to be_valid
    end

    it "本文がない場合は無効" do
      review = build(:review, body: nil)
      expect(review).not_to be_valid
    end

    it "評価がない場合は無効" do
      review = build(:review, rating: nil)
      expect(review).not_to be_valid
    end

    it "評価が1未満の場合は無効" do
      review = build(:review, rating: 0)
      expect(review).not_to be_valid
    end

    it "評価が5を超える場合は無効" do
      review = build(:review, rating: 6)
      expect(review).not_to be_valid
    end

    it "評価が1〜5の場合は有効" do
      (1..5).each do |rating|
        review = build(:review, rating: rating)
        expect(review).to be_valid
      end
    end
  end
end
