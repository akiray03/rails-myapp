class Admin::FeedbacksController < ApplicationController
  def index
    unless current_user&.support?
      flash[:notice] = "Cloud not access to feedback admin page."
      redirect_to root_path
      return
    end

    @feedbacks = Feedback.joins(:user, :feedback_comments).all.order(updated_at: :desc)
  end

  def show
    @feedback = Feedback.find(params[:id])

    unless current_user&.support?
      flash[:notice] = "Cloud not access to feedback admin page."
      redirect_to @feedback
      return
    end

    @feedback_comment = FeedbackComment.new(feedback_id: @feedback.id)
  end

  def edit
  end

  def update
  end
end
