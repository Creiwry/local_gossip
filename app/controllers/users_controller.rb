class UsersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(users_params)

    if @user.save
      flash[:notice] = 'Registration successful'
      redirect_to gossips_path
    else
      flash[:alert] = 'Registration unsuccessful'
      render :new
    end
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

  def users_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :description,
      :age,
      :email,
      :password,
      :password_confirmation,
      :city_id
    )
  end

  def record_not_found
    render plain: '404 Not Found', status: 404
  end
end
