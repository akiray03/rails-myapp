require 'test_helper'

class Admin::FeedbacksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:customer)
    @user.password = 'password'
    @user.save!
    @feedback = feedbacks(:one)
    @feedback.user_id = @user.id
    @feedback.save!

    post login_path, params: { email: @user.email, password: 'password' }
  end

  test "should get index redirect to top page" do
    @user.role = "customer"
    @user.save!
    get admin_feedbacks_url
    assert_redirected_to root_url
  end

  test "should get index" do
    @user.role = "support"
    @user.save!
    get admin_feedbacks_url
    assert_response :success
  end

  test "should get show redirect to customer page" do
    get admin_feedback_url(@feedback)
    assert_redirected_to @feedback
  end

  test "should get show" do
    @user.role = "support"
    @user.save
    get admin_feedback_url(@feedback)
    assert_response :success
  end

  test "should get edit redirect to feedback page" do
    @user.role = "customer"
    @user.save!
    get edit_admin_feedback_url(@feedback)
    assert_redirected_to root_url
  end

  test "should get edit" do
    @user.role = "support"
    @user.save!
    get edit_admin_feedback_url(@feedback)
    assert_response :success
  end

  test "should get edit with customer user" do
    get edit_admin_feedback_url(@feedback)
    assert_redirected_to feedback_url(@feedback)
  end

  test "should get edit with support user" do
    @user.role = "support"
    @user.save
    get edit_admin_feedback_url(@feedback)
    assert_response :success
  end

  test "should update feedback with customer user" do
    @feedback.save
    @user.role = "support"
    @user.save
    patch admin_feedback_url(@feedback), params: { feedback: { description: @feedback.description, title: @feedback.title } }
    assert_redirected_to admin_feedback_url(@feedback)
  end

  test "should update feedback with support user" do
    @user.role = "support"
    @user.save
    @feedback.save
    patch admin_feedback_url(@feedback), params: { feedback: { description: @feedback.description, title: @feedback.title } }
    assert_redirected_to admin_feedback_url(@feedback)
  end
end
