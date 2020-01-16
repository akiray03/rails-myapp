class FeedbacksController < ApplicationController
  before_action :set_feedback, only: [:show, :edit, :update, :destroy]

  # GET /feedbacks
  # GET /feedbacks.json
  def index
    @feedbacks = Feedback.joins(:user).all.order(updated_at: :desc)
  end

  # GET /feedbacks/1
  # GET /feedbacks/1.json
  def show
    @feedback_comment = FeedbackComment.new(feedback_id: @feedback.id)
  end

  # GET /feedbacks/new
  def new
    unless current_user
      redirect_to login_path(redirect_to: new_feedback_path)
      return
    end

    @feedback = Feedback.new
  end

  # GET /feedbacks/1/edit
  def edit
    unless current_user.support?
      flash[:notice] = "Updating feedback requires support role."
      redirect_back fallback_location: feedbacks_path
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

  # PATCH/PUT /feedbacks/1
  # PATCH/PUT /feedbacks/1.json
  def update
    unless current_user
      redirect_to login_path
      return
    end

    unless current_user.support?
      flash[:notice] = "Updating feedback requires support role."
      redirect_back fallback_location: feedbacks_path
      return
    end

    respond_to do |format|
      if @feedback.update(feedback_params)
        format.html { redirect_to @feedback, notice: 'Feedback was successfully updated.' }
        format.json { render :show, status: :ok, location: @feedback }
      else
        format.html { render :edit }
        format.json { render json: @feedback.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feedbacks/1
  # DELETE /feedbacks/1.json
  def destroy
    @feedback.destroy
    respond_to do |format|
      format.html { redirect_to feedbacks_url, notice: 'Feedback was successfully destroyed.' }
      format.json { head :no_content }
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
