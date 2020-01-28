class ApplicationController < ActionController::Base
  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end

    @current_user
  end

  def redirect_to_login_page_if_anonymous_user
    unless current_user
      flash[:notice] = "Please login"
      redirect_to login_path(redirect_to: request.path)
      return true
    end
  end
end
