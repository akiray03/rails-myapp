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
    @feedback = Feedback.find(params[:id])

    unless current_user&.support?
      flash[:notice] = "Cloud not access to feedback admin page."
      redirect_to @feedback
    end
  end

  def update
    @feedback = Feedback.find(params[:id])

    unless current_user&.support?
      flash[:notice] = "Cloud not access to feedback admin page."
      redirect_to @feedback
      return
    end

    respond_to do |format|
      if @feedback.update(feedback_params)
        format.html { redirect_to admin_feedback_path(@feedback), notice: 'Feedback was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def feedback_params
    params.require(:feedback).permit(:title, :description)
  end
end
