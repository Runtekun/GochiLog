require 'rails_helper'

RSpec.describe Genre, type: :model do
  describe "バリデーション" do
    it "有効なジャンルは保存できる" do
      genre = build(:genre)
      expect(genre).to be_valid
    end

    it "名前がない場合は無効" do
      genre = build(:genre, name: nil)
      expect(genre).not_to be_valid
    end

    it "名前が重複している場合は無効" do
      create(:genre, name: "ラーメン")
      genre = build(:genre, name: "ラーメン")
      expect(genre).not_to be_valid
    end
  end
end
