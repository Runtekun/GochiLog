require "test_helper"

class ReviewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
    @review = reviews(:one)
  end

  test "should get index" do
    get reviews_path
    assert_response :success
  end

  test "should get show" do
    get review_path(@review)
    assert_response :success
  end

  test "should get new" do
    get new_review_path
    assert_response :success
  end

  test "should create review" do
    assert_difference("Review.count") do
      post reviews_path, params: {
        shop_name: "テスト店舗2",
        latitude: "35.6812",
        longitude: "139.7671",
        review: { body: "美味しかった", rating: 5 }
      }
    end
    assert_redirected_to reviews_path
  end

  test "should get edit" do
    get edit_review_path(@review)
    assert_response :success
  end

  test "should update review" do
    patch review_path(@review), params: {
      review: { body: "更新しました", rating: 4 }
    }
    assert_redirected_to review_path(@review)
  end

  test "should destroy review" do
    assert_difference("Review.count", -1) do
      delete review_path(@review)
    end
    assert_redirected_to reviews_path
  end

  test "should not edit other user's review" do
    skip "権限制御は未実装のためスキップ"
    other_user = users(:two)
    sign_in other_user
    get edit_review_path(@review)
    assert_redirected_to root_path
  end
end
