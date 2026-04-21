class Admin::ReviewsController < Admin::BaseController
  def index
    @reviews = Review.all.includes(:user, :shop).order(created_at: :desc)
  end

  def destroy
    @review = Review.find(params[:id])
    @review.shop.destroy
    redirect_to admin_reviews_path, notice: "レビューを削除しました。"
  end
end
