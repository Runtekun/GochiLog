require "open-uri"

class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_review, only: [ :show, :edit, :update, :destroy ]
  before_action :set_genres, only: [ :new, :create, :edit, :update ]


  def index
    @q = Review.ransack(params[:q])
    @reviews = @q.result.includes(:user, :shop, :genre).order(created_at: :desc).page(params[:page]).per(12)
    @autocomplete_items = Shop.pluck(:name) + User.pluck(:name) + Genre.pluck(:name)
  end

  def show
  end

  def new
    @review = Review.new
  end

  def create
    # 新しいShopを作成してからReviewを作成
    @shop = Shop.create!(
      name: params[:shop_name],
      latitude: params[:latitude],
      longitude: params[:longitude],
      address: params[:address]
    )

    @review = @shop.reviews.build(review_params)
    @review.user = current_user

    # Shopの写真URLが提供されている場合は、レビューに写真を添付
    attach_shop_photo(@review, params[:shop_photo_url])

    if @review.save
      redirect_to reviews_path, notice: "レビューを投稿しました！"
    else
      @shop.destroy
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to @review, notice: "レビューを更新しました！"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    # レビューを削除すると同時に関連するShopも削除
    @review.shop.destroy
    redirect_to reviews_path, notice: "レビューを削除しました。"
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:body, :rating, :image, :genre_id)
  end

  def set_genres
    @genres = Genre.all
  end

  def attach_shop_photo(review, url)
    return if review.image.attached? || url.blank?
    review.image.attach(io: URI.open(url), filename: "shop_photo.jpg", content_type: "image/jpeg")
  rescue StandardError
    # 写真取得失敗時はそのまま続行
  end
end
