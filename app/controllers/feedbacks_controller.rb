class FeedbacksController < ApplicationController
  before_action :set_feedback, only: [:show]

  # GET /feedbacks
  # GET /feedbacks.json
  def index
    redirect_to_login_page_if_anonymous_user and return

    if current_user.support?
      @feedbacks = Feedback.all.order(updated_at: :desc)
    else
      @feedbacks = Feedback.where(user_id: current_user.id).order(updated_at: :desc)
    end
  end

  # GET /feedbacks/1
  # GET /feedbacks/1.json
  def show
    @feedback_comment = FeedbackComment.new(feedback_id: @feedback.id)
  end

  # GET /feedbacks/new
  def new
    redirect_to_login_page_if_anonymous_user and return

    @feedback = Feedback.new
  end

  def edit
    @feedback = Feedback.find(params[:id])

    unless current_user&.support?
      flash[:notice] = "Cloud not access to feedback admin page."
      redirect_to @feedback
    end
  end

  # POST /feedbacks
  # POST /feedbacks.json
  def create
    unless current_user
      redirect_to login_path(redirect_to: feedbacks_path)
      return
    end

    @feedback = Feedback.new(feedback_params)
    @feedback.user_id = session[:user_id]

    respond_to do |format|
      if @feedback.save
        format.html { redirect_to @feedback, notice: 'Feedback was successfully created.' }
        format.json { render :show, status: :created, location: @feedback }
      else
        format.html { render :new }
        format.json { render json: @feedback.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feedback
      @feedback = Feedback.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def feedback_params
      params.require(:feedback).permit(:title, :description)
    end
end
