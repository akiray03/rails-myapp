class Admin::FeedbacksController < ApplicationController


  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def feedback_params
    params.require(:feedback).permit(:title, :description)
  end
end
