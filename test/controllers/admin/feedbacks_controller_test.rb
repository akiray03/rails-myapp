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


end
