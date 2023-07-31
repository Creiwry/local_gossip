class UsersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def show
    @user = User.find(params[:id])
  end

  private

  def record_not_found
    render plain: '404 Not Found', status: 404
  end
end
