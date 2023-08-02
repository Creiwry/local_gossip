class UsersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def show
    @user = User.find(params[:id])
  end
  
  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = 'User deleted successfully'
      redirect_to gossip_index_path
    else
      flash[:alert] = 'Failed to delete user'
      render :show
    end
  end

  private

  def record_not_found
    render plain: '404 Not Found', status: 404
  end
end
