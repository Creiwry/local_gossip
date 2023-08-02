class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      log_in(user)
      flash[:notice] = "Logged in"
      redirect_to gossips_path
    else
      flash[:alert] = "Failed to log in"
      render :new
    end
  end

  def destroy
    if session.delete(:user_id)
      flash[:notice] = "Signed out"
      redirect_to gossips_path
    else
      flash[:alert] = "Failed to sign out"
      render_back_or_to root_path
    end
  end
end
