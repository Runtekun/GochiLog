class MapsController < ApplicationController
  def index
    # すべての店舗とその店舗に関連するレビューを取得し、JSON形式で返す
    @shops = Shop.includes(:reviews).all
    @shops_json = @shops.map do |shop|
      review = shop.reviews.first
      {
        id: shop.id,
        name: shop.name,
        latitude: shop.latitude,
        longitude: shop.longitude,
        review_id: review&.id
      }
    end.to_json
  end
end
