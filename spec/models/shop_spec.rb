require 'rails_helper'

RSpec.describe Shop, type: :model do
  describe "バリデーション" do
    it "有効な店舗は保存できる" do
      shop = build(:shop)
      expect(shop).to be_valid
    end

    it "名前がない場合は無効" do
      shop = build(:shop, name: nil)
      expect(shop).not_to be_valid
    end

    it "緯度がない場合は無効" do
      shop = build(:shop, latitude: nil)
      expect(shop).not_to be_valid
    end

    it "経度がない場合は無効" do
      shop = build(:shop, longitude: nil)
      expect(shop).not_to be_valid
    end
  end

  describe "アソシエーション" do
    it "店舗を削除するとレビューも削除される" do
      shop = create(:shop)
      create(:review, shop: shop)
      expect { shop.destroy }.to change(Review, :count).by(-1)
    end
  end
end
