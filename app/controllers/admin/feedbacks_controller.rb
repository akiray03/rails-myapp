class Admin::FeedbacksController < ApplicationController
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
