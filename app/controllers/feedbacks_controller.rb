class FeedbacksController < ApplicationController
  before_action :set_feedback, only: [:edit, :show, :update]

  # GET /feedbacks
  # GET /feedbacks.json
  def index
    unless current_user
      flash[:notice] = "Please login"
      redirect_to login_path(redirect_to: request.path)
      return
    end

    if current_user.support?
      @feedbacks = Feedback.all.order(updated_at: :desc)
    else
      @feedbacks = Feedback.where(user_id: current_user.id).order(updated_at: :desc)
    end
  end

  # GET /feedbacks/1
  # GET /feedbacks/1.json
  def show
    unless current_user
      flash[:notice] = "Please login"
      redirect_to login_path(redirect_to: request.path)
      return
    end

    @feedback_comment = FeedbackComment.new(feedback_id: @feedback.id)
  end

  # GET /feedbacks/new
  def new
    unless current_user
      flash[:notice] = "Please login"
      redirect_to login_path(redirect_to: request.path)
      return
    end

    @feedback = Feedback.new
  end

  def edit
    unless current_user
      flash[:notice] = "Please login"
      redirect_to login_path(redirect_to: request.path)
      return
    end

    unless current_user.support?
      flash[:notice] = "Cloud not edit by you."
      redirect_to @feedback
    end
  end

  # POST /feedbacks
  # POST /feedbacks.json
  def create
    unless current_user
      flash[:notice] = "Please login"
      redirect_to login_path(redirect_to: request.path)
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

  def update
    unless current_user
      flash[:notice] = "Please login"
      redirect_to login_path(redirect_to: request.path)
      return
    end

    unless current_user.support?
      flash[:notice] = "Cloud not edit by you."
      redirect_to @feedback
      return
    end

    unless current_user&.support?
      flash[:notice] = "Cloud not access to feedback admin page."
      redirect_to @feedback
      return
    end

    respond_to do |format|
      if @feedback.update(feedback_params)
        format.html { redirect_to feedback_path(@feedback), notice: 'Feedback was successfully updated.' }
      else
        format.html { render :edit }
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
