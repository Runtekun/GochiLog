class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_review

  def create
    @comment = @review.comments.build(comment_params)
    @comment.user = current_user
    @comment.save
  end

  def destroy
    @comment = @review.comments.find(params[:id])
    @comment.destroy if @comment.user == current_user
  end

  private

  def set_review
    @review = Review.find(params[:review_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
