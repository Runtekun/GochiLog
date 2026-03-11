class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @review = Review.find(params[:review_id])
    @review.likes.create!(user: current_user)
    respond_to do |format|
      format.turbo_stream # create.turbo_stream.erbを呼び出す
      format.html { redirect_back_or_to review_path(@review) } 
    end
  end

  def destroy
    @review = Review.find(params[:review_id])
    like = @review.likes.find_by!(user: current_user)
    like.destroy!
    respond_to do |format|
      format.turbo_stream # destroy.turbo_stream.erbを呼び出す
      format.html { redirect_back_or_to review_path(@review) }
    end
  end
end
