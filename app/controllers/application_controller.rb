class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  include SessionsHelper

  private

  def authenticate_user
    unless current_user
      flash[:alert] = "Please log in"
      redirect_to new_session_path
    end
  end

  def record_not_found
    flash[:alert] = '404 not found'
    redirect_to :back
  end

  def error_string(object_of_error)
    message_array = []
    object_of_error.errors.full_messages.each do |msg|
      message_array << msg
    end
    message_array.join('; ')
  end
end
