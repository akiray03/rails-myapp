class FeedbackCommentsController < ApplicationController
  def create
    unless current_user
      redirect_to login_path
      return
    end

    @feedback_comment = FeedbackComment.new(feedback_comment_params)
    @feedback_comment.feedback_id = params[:feedback_id]
    @feedback_comment.user_id = current_user.id

    @feedback_comment.save!

    redirect_to @feedback_comment.feedback, notice: "Feedback comment was successfully created."
  end

  private

  def feedback_comment_params
    params.require(:feedback_comment).permit(:body)
  end
end
