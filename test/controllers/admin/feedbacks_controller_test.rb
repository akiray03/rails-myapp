require 'test_helper'

class Admin::FeedbacksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:customer)
    @user.password = 'password'
    @user.save
    @feedback = feedbacks(:one)
    @feedback.user_id = @user.id

    post login_path, params: { email: @user.email, password: 'password' }
  end

  test "should get index" do
    get admin_feedbacks_url
    assert_response :success
  end

  test "should get show" do
    get admin_feedback_url(@feedback)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_feedback_url(@feedback)
    assert_response :success
  end

  #test "should get update" do
  #  patch admin_feedback_url(@feedback), params: {  }
  #  assert_response :success
  #end
end
