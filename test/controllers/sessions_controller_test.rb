require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get login_path
    assert_response :success
  end

  #test "should get create" do
  #  get sessions_create_url
  #  assert_response :success
  #end

  test "should get destroy" do
    delete logout_path
    assert_redirected_to root_path
  end

end
