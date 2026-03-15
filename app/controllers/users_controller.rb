class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews.includes(:shop).order(created_at: :desc)
  end
end
