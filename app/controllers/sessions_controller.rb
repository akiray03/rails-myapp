class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    unless user
      render :new
      return
    end

    if user.authenticate(params[:password])
      session[:user_id] = user.id
      path = params[:redirect_to]
      if path && path =~ /^\// && path != "/users/new"
        redirect_to path
      else
        redirect_to root_path
      end
    else
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path
  end
end
