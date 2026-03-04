class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_review, only: [:show, :edit, :update, :destroy]


  def index
    @reviews = Review.includes(:user, :shop).order(created_at: :desc)
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
      longitude: params[:longitude]
    )

    @review = @shop.reviews.build(review_params)
    @review.user = current_user

    if @review.save
      redirect_to reviews_path, notice: 'レビューを投稿しました！'
    else
      @shop.destroy
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to @review, notice: 'レビューを更新しました！'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    # レビューを削除すると同時に関連するShopも削除
    @review.shop.destroy
    redirect_to reviews_path, notice: 'レビューを削除しました。'
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:body, :rating, :image) 
  end
end
