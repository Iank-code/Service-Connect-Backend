require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get login" do
    get sessions_login_url
    assert_response :success
  end

  test "should get signup" do
    get sessions_signup_url
    assert_response :success
  end
end
