require "test_helper"

class HabitPostsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get habit_posts_index_url
    assert_response :success
  end
end
