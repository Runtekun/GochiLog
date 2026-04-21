class Admin::DashboardController < Admin::BaseController
  def index
    @users_count = User.count
    @reviews_count = Review.count
  end
end
