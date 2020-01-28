require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get login_path
    assert_response :success
  end

  test "should get create" do
    @user = users(:customer)
    @user.password = 'password'
    @user.save!

    post login_process_path, params: {email: @user.email, password: 'password'}
    assert_redirected_to root_path
    assert_equal @user.id, session[:user_id]
  end

  test "should get destroy" do
    delete logout_path
    assert_redirected_to root_path
  end

end
