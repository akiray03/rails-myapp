require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:customer)
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user and login by anonymous user" do
    assert_difference('User.count') do
      post users_url, params: {
          user: {
              email: "user-#{User.count}@example.com",
              name: @user.name,
              password: "something-password",
              role: @user.role
          }
      }
    end

    assert_redirected_to user_url(User.last)
    assert_equal User.last.id, session[:user_id]
  end

  test "should create user and login by logged-in user" do
    support_user = users(:support)
    support_user.password = 'password'
    support_user.save!

    post login_process_path, params: {email: support_user.email, password: 'password'}

    assert_difference('User.count') do
      post users_url, params: {
          user: {
              email: "user-#{User.count}@example.com",
              name: @user.name,
              password: "something-password",
              role: @user.role
          }
      }
    end

    assert_redirected_to user_url(User.last)
    # login user is not changed.
    assert_equal support_user.id, session[:user_id]
  end


  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: {
        user: {
            email: @user.email,
            name: @user.name,
        }
    }
    assert_redirected_to user_url(@user)
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end
end
