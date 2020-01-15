require 'test_helper'

class FeedbackCommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:customer)
    @user.password = 'password'
    @user.save
    @feedback = feedbacks(:one)
    @feedback.user_id = @user.id
    @feedback.save

    post login_path, params: { email: @user.email, password: 'password' }
  end

  test "should create feedback comment" do
    post feedback_comments_url(@feedback.id), params: { feedback_comment: { body: 'comment body' } }
    assert_redirected_to @feedback
  end

end
