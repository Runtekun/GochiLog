class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @review = Review.find(params[:review_id])
    @review.likes.create!(user: current_user)
  end

  def destroy
    @review = Review.find(params[:review_id])
    like = @review.likes.find_by!(user: current_user)
    like.destroy!
  end
end
