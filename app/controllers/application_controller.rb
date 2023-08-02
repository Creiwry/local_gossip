class ApplicationController < ActionController::Base
  include SessionsHelper

  private

  def authenticate_user
    unless current_user
      flash[:alert] = "Please log in"
      redirect_to new_session_path
    end
  end
end
