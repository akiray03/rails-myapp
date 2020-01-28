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
