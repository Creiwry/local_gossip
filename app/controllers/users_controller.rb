class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    @cities = City.all
  end

  def create
    @cities = City.all
    @user = User.new(users_params)

    if @user.save
      flash[:notice] = 'Registration successful'
      log_in(@user)
      redirect_to root_path
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
end
