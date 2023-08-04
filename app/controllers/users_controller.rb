class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @my_gossip = @user.gossips
    @liked_gossip = @user.likes.select { |like| like.likeable_type == 'Gossip' }.map(&:likeable)
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
      redirect_to user_path(@user)
    else
      flash.now[:alert] = error_string(@user)
      render :new
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = 'User deleted successfully'
      redirect_to gossip_index_path
    else
      flash.now[:alert] = error_string(@user)
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




