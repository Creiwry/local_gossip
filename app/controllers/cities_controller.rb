class CitiesController < ApplicationController
  def show
    @city = City.find(params[:id])
    @gossips = @city.users.map(&:gossips).flatten
  end
end
